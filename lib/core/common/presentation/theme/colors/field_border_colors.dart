import 'dart:ui';

/// Цвета границ полей ввода
abstract class FieldBordersColors {
  /// Конструктор для цветов границ полей ввода
  const FieldBordersColors({
    required this.main,
    required this.accent,
    required this.negative,
    required this.focus,
  });

  /// Изначальный цвет границ
  final Color main;

  /// Цвет выбранного поля ввода
  final Color accent;

  /// Цвет границы с ошибкой
  final Color negative;

  /// Цвет второстепенной кнопки
  final Color focus;

  /// Цвет границы неактивного поля
  Color get inactive => main.withOpacity(0.4);
}
