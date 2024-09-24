import 'dart:ui';

abstract class FieldBordersColors {
  const FieldBordersColors({
    required this.main,
    required this.accent,
    required this.negative,
    required this.focus,
  });

  final Color main;

  final Color accent;

  final Color negative;

  final Color focus;

  Color get inactive => main.withOpacity(0.4);
}
