import 'package:flutter/widgets.dart';

abstract class CaptionTypography {
  const CaptionTypography({
    required this.c1,
    required this.c2,
    required this.c3,
  });

  /// Caption / C1
  final TextStyle c1;

  /// Caption / C2
  final TextStyle c2;

  /// Caption / C3
  final TextStyle c3;
}
