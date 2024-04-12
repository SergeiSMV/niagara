import 'package:flutter/widgets.dart';

abstract class TextTypography {
  const TextTypography({
    required this.tx1SemiBold,
    required this.tx1Medium,
    required this.tx2SemiBold,
    required this.tx2Medium,
    required this.tx3SemiBold,
    required this.tx3Medium,
    required this.tx4Medium,
  });

  /// Text / Tx1  - SemiBold
  final TextStyle tx1SemiBold;

  /// Text / Tx1  - Medium
  final TextStyle tx1Medium;

  /// Text / Tx2 - SemiBold
  final TextStyle tx2SemiBold;

  /// Text / Tx2  - Medium
  final TextStyle tx2Medium;

  /// Text / Tx3 - SemiBold
  final TextStyle tx3SemiBold;

  /// Text / Tx3  - Medium
  final TextStyle tx3Medium;

  /// Text / Tx4  - Medium
  final TextStyle tx4Medium;
}
