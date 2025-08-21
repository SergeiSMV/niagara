import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../../features/notifications/domain/repositories/i_notifications_repository.dart';
import '../../../core.dart';
import 'local_notifications_service.dart';

/// Callback для обработки foreground сообщений
typedef ForegroundMessageCallback = void Function(RemoteMessage message);

/// Callback для обработки нажатия на push-уведомление
typedef PushTapCallback = void Function(RemoteMessage message);

/// Callback для обработки нажатия на локальное уведомление
typedef LocalNotificationTapCallback = void Function(String? payload);

/// Сервис для работы с Firebase Cloud Messaging (FCM).
///
/// Реализует паттерн Singleton для обеспечения единой точки доступа к
/// функционалу FCM.
///
/// Основные возможности:
/// - Инициализация Firebase Messaging
/// - Управление токенами устройства
/// - Обработка push-уведомлений
/// - Управление разрешениями на уведомления
@singleton
class FirebaseMessageServices {
  FirebaseMessageServices(
    this._logger,
    this._lns,
    this._notificationsRepository,
  );

  /// Логгирование
  final IAppLogger _logger;

  /// Сервис для работы с локальными уведомлениями
  final LocalNotificationsService _lns;

  /// Сервис для работы с уведомлениями
  final INotificationsRepository _notificationsRepository;

  /// Экземпляр Firebase Messaging для работы с FCM
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  /// Callback для обработки foreground сообщений
  ForegroundMessageCallback? _foregroundCallback;

  /// Callback для обработки нажатия на push-уведомление
  PushTapCallback? _pushTapCallback;

  /// Callback для обработки нажатия на локальное уведомление
  LocalNotificationTapCallback? _localNotificationTapCallback;

  /// Устанавливает callback для обработки foreground сообщений
  void setForegroundCallback(ForegroundMessageCallback callback) =>
      _foregroundCallback = callback;

  /// Устанавливает callback для обработки нажатия на push-уведомление
  void setPushTapCallback(PushTapCallback callback) =>
      _pushTapCallback = callback;

  /// Устанавливает callback для обработки нажатия на локальное уведомление
  void setLocalNotificationTapCallback(
    LocalNotificationTapCallback callback,
  ) =>
      _localNotificationTapCallback = callback;

  /// Инициализирует сервис Firebase Messaging.
  Future<void> init() async {
    // Устанавливаем callback для обработки нажатий на локальные уведомления
    _lns.setNotificationTapCallback(
      (payload) => _localNotificationTapCallback?.call(payload),
    );
    // Получает токен из Firebase Messaging
    await _firebaseMessaging.getToken().then((token) async {
      if (token != null) {
        await _notificationsRepository.registerFcmDevice(token: token);
      }

      _logger.log(
        level: LogLevel.info,
        message: 'FirebaseMessageService ::: getToken: $token',
      );
    }).onError((error, stackTrace) {
      _logger.handle(
        error ?? 'error',
        stackTrace,
        'FirebaseMessageService ::: getToken Error ::: $runtimeType',
      );
    });

    // Обновляет токен на Firebase Messaging
    _firebaseMessaging.onTokenRefresh.listen((token) async {
      await _notificationsRepository.registerFcmDevice(token: token);
      _logger.log(
        level: LogLevel.info,
        message: 'FirebaseMessageService ::: onTokenRefresh: $token',
      );
    }).onError((error) {
      _logger.handle(
        error,
        StackTrace.current,
        'FirebaseMessaging.onTokenRefresh ::: $runtimeType',
      );
    });

    /// Запрашивает разрешение для отправки push-уведомлений
    await _requestPermission();

    /// Обрабатывает полученные push-уведомления
    FirebaseMessaging.onMessage.listen((message) async {
      /// Вызываем callback если он установлен
      _foregroundCallback?.call(message);

      /// Отображает локальное уведомление
      if (message.notification != null) {
        // Убеждаемся, что сервис инициализирован
        await _lns.init();

        /// Формирует payload для локального уведомления
        final payloadData = {
          'data': message.data,
          'messageId': message.messageId,
          'title': message.notification?.title,
          'body': message.notification?.body,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        };

        /// Кодирует payload в JSON
        final payloadJson = json.encode(payloadData);

        /// Отображает локальное уведомление
        await _lns.showNotification(
          title: message.notification?.title ?? '',
          body: message.notification?.body ?? '',
          payload: payloadJson,
          data: message.data,
        );
      }
    }).onError((error) {
      _logger.handle(
        error,
        StackTrace.current,
        'FirebaseMessaging.onMessage ::: $runtimeType',
      );
    });

    /// Обрабатывает открытие свёрнутого приложения из уведомления (background)
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _pushTapCallback?.call(message);
    });
  }

  /// Запрашивает разрешения на отправку уведомлений у пользователя.
  Future<void> _requestPermission() async {
    await _firebaseMessaging.requestPermission().then(
      (value) async {
        final isAuthorized =
            value.authorizationStatus == AuthorizationStatus.authorized;

        /// Если разрешение не получено, то ничего не делаем
        if (!isAuthorized) return;

        /// Устанавливает параметры отображения уведомлений
        await _firebaseMessaging.setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );

        /// Регистрирует обработчик фоновых сообщений
        FirebaseMessaging.onBackgroundMessage(
          (message) async {
            _logger.log(
              level: LogLevel.info,
              message:
                  'FirebaseMessageService ::: onBackgroundMessage: $message',
            );
          },
        );
      },
    ).onError((error, stackTrace) {
      _logger.handle(
        error ?? 'error',
        stackTrace,
        'FirebaseMessageService ::: _requestPermission ::: $runtimeType',
      );
      return null;
    });
  }

  /// Проверяет текущее состояние разрешения на отправку уведомлений
  Future<bool> checkPermission() async {
    final isAuthorized = await _firebaseMessaging.requestPermission().then(
          (value) =>
              value.authorizationStatus == AuthorizationStatus.authorized,
        );
    return isAuthorized;
  }
}
