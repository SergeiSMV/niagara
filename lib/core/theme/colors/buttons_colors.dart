import 'dart:ui';

/// Цвета кнопок 
abstract class ButtonColors {
  /// Конструктор для цветов кнопок
  const ButtonColors({
    required this.primary,
    required this.accent,
    required this.inactive,
    required this.secondary,
  });

  /// Основной цвет основы
  final Color primary;

  /// Акцентный цвет основы
  final Color accent;

  /// Цвет неактивной кнопки
  final Color inactive;

  /// Цвет второстепенной кнопки
  final Color secondary;
}
