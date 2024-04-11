import 'dart:ui';

abstract class TextColors {
  const TextColors({
    required this.main,
    required this.accent,
    required this.error,
    required this.secondary,
    required this.white,
  });

  final Color main;

  final Color accent;

  final Color error;

  final Color secondary;

  final Color white;
}
