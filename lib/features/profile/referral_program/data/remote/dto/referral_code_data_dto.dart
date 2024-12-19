// ignore_for_file: sort_constructors_first

import 'package:niagara_app/core/core.dart';

class ReferralCodeDataDto extends Equatable {
  final String code;
  final String message;

  @override
  List<Object?> get props => [code, message];

  const ReferralCodeDataDto({
    required this.code,
    required this.message,
  });

  factory ReferralCodeDataDto.fromJson(Map<String, dynamic> json) =>
      ReferralCodeDataDto(
        code: json['referal_promocode'] as String,
        message: json['description'] as String,
      );
}
