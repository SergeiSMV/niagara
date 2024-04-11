import 'dart:ui';

abstract class InfoColors {
  const InfoColors({
    required this.red,
    required this.bgRed,
    required this.green,
    required this.blue,
    required this.bgBlue,
  });

  final Color red;

  final Color bgRed;

  final Color green;

  final Color blue;

  final Color bgBlue;
}
