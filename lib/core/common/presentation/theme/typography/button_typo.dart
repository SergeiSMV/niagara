import 'package:flutter/widgets.dart';

abstract class ButtonTypography {
  const ButtonTypography({
    required this.btn1bold,
    required this.btn1semiBold,
    required this.btn2bold,
    required this.btn2semiBold,
    required this.btn3bold,
    required this.btn3semiBold,
  });

  /// Button / Btn1  - Bold
  final TextStyle btn1bold;

  /// Button / Btn1  - SemiBold
  final TextStyle btn1semiBold;

  /// Button / Btn2 - Bold
  final TextStyle btn2bold;

  /// Button / Btn2 - SemiBold
  final TextStyle btn2semiBold;

  /// Button / Btn3 - Bold
  final TextStyle btn3bold;

  /// Button / Btn3 - SemiBold
  final TextStyle btn3semiBold;
}
