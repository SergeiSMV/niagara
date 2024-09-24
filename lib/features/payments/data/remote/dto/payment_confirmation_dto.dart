// ignore_for_file: sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/payment_statuses.dart';

part 'payment_confirmation_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PaymentConfirmationDto extends Equatable {
  const PaymentConfirmationDto({
    required this.success,
    required this.status,
    required this.confirmationUrl,
  });

  final bool success;

  final PaymentStatus status;

  final String confirmationUrl;

  factory PaymentConfirmationDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentConfirmationDtoFromJson(json);

  @override
  List<Object?> get props => [success, status, confirmationUrl];
}
