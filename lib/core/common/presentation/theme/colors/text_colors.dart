import 'dart:ui';

/// Цвета текста
abstract class TextColors {
  /// Конструктор для цветов текста
  const TextColors({
    required this.main,
    required this.accent,
    required this.error,
    required this.secondary,
    required this.white,
  });

  /// Основной черный цвет текста
  final Color main;

  /// Акцентный цвет текста (цены, текстовые ссылки, ключевые слова)
  final Color accent;

  /// Цвет текста уведомлений с ошибками
  final Color error;

  /// Второстепенный цвет текста
  final Color secondary;

  /// Цвет текста для темного фона
  final Color white;
}
