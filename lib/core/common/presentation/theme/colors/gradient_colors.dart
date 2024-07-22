import 'dart:ui';

abstract class GradientColors {
  const GradientColors({
    required this.bgGradient,
    required this.coinAndStars,
    required this.bgStoryDark,
    required this.bgStoryLight,
  });

  final List<Color> bgGradient;

  final List<Color> coinAndStars;

  final List<Color> bgStoryDark;

  final List<Color> bgStoryLight;
}
