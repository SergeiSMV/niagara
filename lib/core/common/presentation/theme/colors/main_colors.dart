import 'dart:ui';

abstract class MainColors {
  const MainColors({
    required this.primary,
    required this.accent,
    required this.light,
    required this.bgCard,
    required this.white,
  });

  final Color primary;

  final Color accent;

  final Color light;

  final Color bgCard;

  final Color white;
}
