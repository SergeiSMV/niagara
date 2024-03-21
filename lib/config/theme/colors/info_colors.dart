import 'dart:ui';

/// Цвета системных уведомлений
abstract class InfoColors {
  /// Конструктор цветов системных уведомлений
  const InfoColors({
    required this.red,
    required this.bgRed,
    required this.green,
    required this.blue,
    required this.bgBlue,
  });

  /// Цвет иконок, тэгов, системных уведомлений
  final Color red;

  /// Основа уведомлений с ошибкой
  final Color bgRed;

  /// Цвет иконок, тэгов, системных уведомлений
  final Color green;

  /// Цвет иконок, тэгов, системных уведомлений
  final Color blue;

  /// Цвет фона системных уведомлений
  final Color bgBlue;
}
