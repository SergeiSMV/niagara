import 'dart:ui';

/// Градиентные цвета
abstract class GradientColors {
  /// Конструктор градиентных цветов
  const GradientColors({
    required this.bgGradient,
    required this.coinAndStars,
  });

  /// Бэк превью сторис
  final List<Color> bgGradient;

  /// Цвет основы под Niagara coin и звезды с отзывами
  final List<Color> coinAndStars;
}
