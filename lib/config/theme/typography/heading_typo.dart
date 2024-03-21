import 'package:flutter/widgets.dart';

/// Типографика заголовков
abstract class HeadingTypography {
  /// Конструктор для типографики заголовков
  const HeadingTypography({
    required this.h1,
    required this.h2,
    required this.h3,
  });

  /// Heading / H1
  final TextStyle h1;

  /// Heading / H2
  final TextStyle h2;

  /// Heading / H3
  final TextStyle h3;
}
