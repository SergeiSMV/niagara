import 'dart:ui';

abstract class GradientColors {
  const GradientColors({
    required this.bgGradient,
    required this.coinAndStars,
  });

  final List<Color> bgGradient;

  final List<Color> coinAndStars;
}
