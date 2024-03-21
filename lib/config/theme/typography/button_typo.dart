import 'package:flutter/widgets.dart';

/// Типографика кнопок
abstract class ButtonTypography {
  /// Конструктор для типографики кнопок
  const ButtonTypography({
    required this.btn1b,
    required this.btn1sb,
    required this.btn2b,
    required this.btn2sb,
    required this.btn3b,
    required this.btn3sb,
  });

  /// Button / Btn1  - Bold
  final TextStyle btn1b;

  /// Button / Btn1  - SemiBold
  final TextStyle btn1sb;

  /// Button / Btn2 - Bold
  final TextStyle btn2b;

  /// Button / Btn2 - SemiBold
  final TextStyle btn2sb;

  /// Button / Btn3 - Bold
  final TextStyle btn3b;

  /// Button / Btn3 - SemiBold
  final TextStyle btn3sb;
}
