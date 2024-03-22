import 'package:flutter/widgets.dart';

/// Типографика описаний
abstract class DescriptionTypography {
  /// Конструктор для типографики описаний
  const DescriptionTypography({
    required this.des1,
    required this.des2,
    required this.des3,
    required this.des4,
  });

  /// Description / Des1
  final TextStyle des1;

  /// Description / Des2
  final TextStyle des2;

  /// Description / Des3
  final TextStyle des3;

  /// Description / Des4
  final TextStyle des4;
}
