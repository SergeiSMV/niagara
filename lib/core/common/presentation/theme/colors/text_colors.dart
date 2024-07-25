import 'dart:ui';

abstract class TextColors {
  const TextColors({
    required this.main,
    required this.accent,
    required this.error,
    required this.secondary,
    required this.white,
    required this.blue,
  });

  final Color main;

  final Color accent;

  final Color error;

  final Color secondary;

  final Color white;

  final Color blue;

  Color get white80 => white.withOpacity(0.8);
}
