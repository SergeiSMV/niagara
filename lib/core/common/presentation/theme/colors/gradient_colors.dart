import 'dart:ui';

abstract class GradientColors {
  const GradientColors({
    required this.bgGradient,
    required this.coinAndStars,
    required this.bgStoryDark1,
    required this.bgStoryDark2,
    required this.bgStoryLight1,
    required this.bgStoryLight2,
    required this.storyPreview,
    required this.referralBanner,
    required this.promotionsBanner,
    required this.vipBanner,
  });

  final List<Color> bgGradient;

  final List<Color> coinAndStars;

  final List<Color> storyPreview;

  final List<Color> bgStoryDark1;

  final List<Color> bgStoryDark2;

  final List<Color> bgStoryLight1;

  final List<Color> bgStoryLight2;

  final List<Color> referralBanner;

  final List<Color> promotionsBanner;

  final List<Color> vipBanner;
}
