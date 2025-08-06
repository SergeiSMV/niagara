import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../../../core/core.dart';
import '../../../../../core/utils/services/firebase/firebase_message_service.dart';
import '../../../domain/model/notification.dart';
import '../../../domain/model/notifications_types.dart';
import '../../../domain/use_cases/get_notifications_use_case.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';
part 'notifications_bloc.freezed.dart';

typedef _Emit = Emitter<NotificationsState>;

@injectable
class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc(
    this._getNotificationsUseCase,
    this._firebaseMessageServices,
    this._logger,
  ) : super(const _Loading()) {
    on<_LoadingEvent>(_getNotifications);
    on<_LoadMoreEvent>(_onLoadMore);
    on<_SetSortEvent>(_setSort);

    add(const _LoadingEvent(isForceUpdate: true));

    // Настраиваем callback для получения push-уведомлений
    _setupFirebaseMessageListeners();
  }

  // Логгирование
  final IAppLogger _logger;

  /// Usecase для получения уведомлений
  final GetNotificationsUseCase _getNotificationsUseCase;

  /// Сервис для работы с Firebase Messaging
  final FirebaseMessageServices _firebaseMessageServices;

  /// Тип сортировки уведомлений
  NotificationsTypes _type = NotificationsTypes.all;

  /// Геттер для получения типа сортировки уведомлений
  NotificationsTypes get type => _type;

  /// Текущая страница
  int _current = 1;

  /// Общее количество страниц
  int _total = 0;

  /// Идентификатор уведомления, которое тапнули
  String? _tappedMessageId;

  /// Флаг, указывающий, было ли приложение открыто из пуша
  bool _pushIsTapped = false;

  /// Флаг, указывающий, есть ли ещё уведомления для загрузки
  bool get hasMore => _total > _current;

  /// Настраивает слушатели Firebase Messaging
  void _setupFirebaseMessageListeners() {
    // Устанавливаем callback для обработки foreground сообщений
    _firebaseMessageServices
      ..setForegroundCallback(_onForegroundMessage)

      // Устанавливаем callback для обработки нажатий на локальные уведомления
      ..setLocalNotificationTapCallback(_onLocalNotificationTap)

      // Устанавливаем callback для обработки нажатий на push-уведомление
      // в фоновом режиме
      ..setPushTapCallback(_onBackgroundPushTap);

    // Слушаем открытие приложения из push-уведомления в фоновом режиме
    FirebaseMessaging.onMessageOpenedApp.listen(_onForegroundMessage);
  }

  /// Проверяет, было ли приложение открыто из пуша при закрытом приложении
  Future<void> _checkIfOpenedFromPush() async {
    final message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      _tappedMessageId = message.messageId;
      _pushIsTapped = true;
    }
  }

  /// Обработчик получения уведомления во время работы приложения
  void _onForegroundMessage(RemoteMessage message) {
    _logger.log(
      level: LogLevel.info,
      message: 'NotificationsBloc ::: _onForegroundMessage',
    );
    add(const _LoadingEvent(isForceUpdate: true));
  }

  /// Обработчик нажатия на локальное уведомление
  void _onLocalNotificationTap(String? payload) {
    if (payload != null) {
      try {
        final data = json.decode(payload) as Map<String, dynamic>;
        final messageId = data['messageId'] as String?;
        _pushIsTapped = true;
        _tappedMessageId = messageId;
        _logger.log(
          level: LogLevel.info,
          message: 'NotificationsBloc ::: _onLocalNotificationTap ID ::: '
              '$_tappedMessageId',
        );
        add(const _LoadingEvent(isForceUpdate: true));
      } on Exception catch (e) {
        _logger.handle(
          e,
          StackTrace.current,
          'NotificationsBloc ::: Error payload decode ::: $runtimeType',
        );
      }
    }
  }

  /// Обработчик нажатия на уведомление в фоновом режиме
  void _onBackgroundPushTap(RemoteMessage message) {
    _logger.log(
      level: LogLevel.info,
      message: 'NotificationsBloc ::: _onBackgroundPushTap ::: '
          '${message.messageId}',
    );
    _pushIsTapped = true;
    _tappedMessageId = message.messageId;
    add(const _LoadingEvent(isForceUpdate: true));
  }

  /// Получает список уведомлений с сервера
  Future<void> _getNotifications(_LoadingEvent event, _Emit emit) async {
    /// Проверяем, было ли приложение открыто из пуша при закрытом приложении
    await _checkIfOpenedFromPush();

    /// Если нужно обновить список уведомлений, то обновляем его
    if (event.isForceUpdate) {
      emit(const _Loading());
      _current = 0;
    }

    /// Получаем список уведомлений
    final groupedNotifications = state.maybeMap(
      loaded: (state) => state.groupedNotifications,
      orElse: () => const <GroupedNotifications>[],
    );

    /// Получаем список непрочитанных уведомлений
    final unreadNotifications = state.maybeMap(
      loaded: (state) => state.unreadNotifications,
      orElse: () => const <NotificationItem>[],
    );

    /// Увеличиваем текущую страницу
    _current++;

    /// Получаем список уведомлений с сервера
    await _getNotificationsUseCase(
      NotificationsParams(
        page: _current,
        type: _type,
      ),
    ).fold(
      (failure) => failure is NoInternetFailure
          ? emit(const _NoInternet())
          : emit(const _Error()),
      (data) {
        _current = data.pagination.current;
        _total = data.pagination.total;

        emit(
          _Loaded(
            groupedNotifications: event.isForceUpdate
                ? _sortForDate(
                    data.notifications.where((e) => !e.isNew).toList(),
                  )
                : [
                    ...groupedNotifications,
                    ..._sortForDate(
                      data.notifications.where((e) => !e.isNew).toList(),
                    ),
                  ],
            unreadNotifications: event.isForceUpdate
                ? data.notifications.where((e) => e.isNew).toList()
                : [
                    ...unreadNotifications,
                    ...data.notifications.where((e) => e.isNew),
                  ],
            isNewNotifications: _thereAreNewNotifications(data.notifications),
          ),
        );

        /// Обрабатываем нажатие на Push-уведомление
        if (_pushIsTapped && _tappedMessageId != null) {
          _onPushTap(emit, data.notifications);
        }
      },
    );
  }

  /// Загружает больше уведомлений
  Future<void> _onLoadMore(_LoadMoreEvent event, _Emit emit) async {
    if (state is _Loading) return;
    if (hasMore) {
      add(const _LoadingEvent(isForceUpdate: false));
    }
  }

  /// Устанавливает тип сортировки уведомлений
  void _setSort(_SetSortEvent event, _Emit emit) {
    _type = event.sort;
    add(const _LoadingEvent(isForceUpdate: true));
  }

  /// Разделение уведомлений по датам (по дням)
  List<GroupedNotifications> _sortForDate(
    List<NotificationItem> notifications,
  ) {
    final List<GroupedNotifications> groupedNotifications = [];

    // Проходим по списку уведомлений
    for (final notification in notifications) {
      // Получаем дату уведомления
      final DateTime date = notification.date;

      // Ищем существующую группу для этой даты
      final existingGroup = groupedNotifications.firstWhereOrNull(
        (element) => element.date.day == date.day,
      );

      if (existingGroup != null) {
        // Если группа уже существует, добавляем уведомление в ее список
        existingGroup.groupedNotifications.add(notification);
      } else {
        // Если группа не существует, создаем новую группу
        final newGroup = GroupedNotifications(
          date: date,
          groupedNotifications: [notification],
        );
        groupedNotifications.add(newGroup);
      }
    }

    return groupedNotifications;
  }

  /// Определяем есть ли новые уведомления
  bool _thereAreNewNotifications(List<NotificationItem> notifications) =>
      notifications.any((notification) => notification.isNew);

  /// Обработчик навигации по нажатию на Push-уведомление
  void _onPushTap(_Emit emit, List<NotificationItem> notifications) {
    /// Получаем уведомление по id
    final notification = notifications.firstWhere(
      (element) => element.id == _tappedMessageId,
    );

    if (notification.type == NotificationsTypes.product) {
      emit(
        _OpenedProductFromPush(
          productId: notification.link,
          productName: notification.title,
        ),
      );
    } else if (notification.type == NotificationsTypes.product_group) {
      // открываем группу товаров
      emit(_OpenedProductGroupFromPush(groupId: notification.link));
    } else if (notification.type == NotificationsTypes.product) {
      // открываем страницу товара
      emit(
        _OpenedProductFromPush(
          productId: notification.link,
          productName: notification.title,
        ),
      );
    } else if (notification.type == NotificationsTypes.get_rating) {
      // открываем страницу оценки заказа
      emit(_OpenedGetRatingFromPush(orderID: notification.link));
    } else if (notification.type == NotificationsTypes.call) {
      // открываем телефонный номер
      emit(_OpenedCallFromPush(phoneNumber: notification.link));
    } else {
      emit(const _OpenedFromPush());
    }
    _pushIsTapped = false;
    _tappedMessageId = null;
  }
}
