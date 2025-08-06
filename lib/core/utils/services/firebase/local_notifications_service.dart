import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../core.dart';

/// Callback для обработки нажатия на уведомление
typedef NotificationTapCallback = void Function(String? payload);

/// Сервис для работы с локальными уведомлениями.
///
/// Реализует паттерн Singleton для обеспечения единой точки доступа к
/// функционалу локальных уведомлений.
@singleton
class LocalNotificationsService {
  LocalNotificationsService();

  /// Callback для обработки нажатия на уведомление
  NotificationTapCallback? _onNotificationTap;

  /// Плагин для работы с локальными уведомлениями
  final FlutterLocalNotificationsPlugin _notifyPlugin =
      FlutterLocalNotificationsPlugin();

  /// Устанавливает callback для обработки нажатия на уведомление
  void setNotificationTapCallback(NotificationTapCallback callback) {
    _onNotificationTap = callback;
  }

  /// Инициализирует сервис локальных уведомлений.
  Future<void> init() async => await _initNotification();

  /// Показывает локальное уведомление.
  ///
  /// Параметры:
  /// - [title] - Заголовок уведомления
  /// - [body] - Текст уведомления
  /// - [payload] - Дополнительные данные
  /// - [data] - Дополнительные данные
  Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
    Map<String, dynamic>? data,
  }) async {
    /// Инициализирует настройки для Android
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_ID',
      'channel_name',
      channelDescription: 'channel_description',
      importance: Importance.max,
      priority: Priority.high,
      enableLights: true,
    );

    /// Инициализирует настройки для iOS
    const iOSPlatformChannelSpecifics = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    /// Инициализирует настройки для платформы
    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    /// Генерирует случайный идентификатор
    final id = Random().nextInt(99999);

    /// Показывает уведомление на всех платформах
    await _notifyPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  /// Инициализирует сервис локальных уведомлений.
  Future<void> _initNotification() async {
    // Инициализирует настройки для Android
    const initSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    // Инициализирует настройки для iOS
    const initSettingsIOS = DarwinInitializationSettings();

    // Инициализирует настройки для платформы
    const initializationSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    // Инициализирует плагин для работы с локальными уведомлениями
    await _notifyPlugin.initialize(
      initializationSettings,

      /// Обрабатываем нажатие на локальное уведомление,
      /// когда приложение открыто
      onDidReceiveNotificationResponse: (NotificationResponse response) =>
          _onNotificationTap?.call(response.payload),
    );
  }
}
