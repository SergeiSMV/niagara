import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/notifications/domain/model/notification.dart';
import 'package:niagara_app/features/notifications/domain/model/notifications_types.dart';
import 'package:niagara_app/features/notifications/domain/use_cases/get_notifications_use_case.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';
part 'notifications_bloc.freezed.dart';

typedef _Emit = Emitter<NotificationsState>;

@injectable
class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc(
    this._getNotificationsUseCase,
  ) : super(const _Loading()) {
    on<_LoadingEvent>(_getNotifications);
    on<_LoadMoreEvent>(_onLoadMore);
    on<_SetSortEvent>(_setSort);

    add(const _LoadingEvent(isForceUpdate: true));
  }

  final GetNotificationsUseCase _getNotificationsUseCase;

  NotificationsTypes _type = NotificationsTypes.all;
  NotificationsTypes get type => _type;

  int _current = 1;
  int _total = 0;
  bool get hasMore => _total > _current;

  Future<void> _getNotifications(_LoadingEvent event, _Emit emit) async {
    if (event.isForceUpdate) {
      emit(const _Loading());
      _current = 0;
    }

    final groupedNotifications = state.maybeMap(
      loaded: (state) => state.groupedNotifications,
      orElse: () => const <GroupedNotifications>[],
    );

    final unreadNotifications = state.maybeMap(
      loaded: (state) => state.unreadNotifications,
      orElse: () => const <NotificationItem>[],
    );

    _current++;

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
      },
    );
  }

  Future<void> _onLoadMore(_LoadMoreEvent event, _Emit emit) async {
    if (state is _Loading) return;
    if (hasMore) {
      add(const _LoadingEvent(isForceUpdate: false));
    }
  }

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
}
