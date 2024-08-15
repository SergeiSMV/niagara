// ignore_for_file: sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/core.dart';

part 'order_placing_info_dto.g.dart';

/// DTO объекта, который нужно передать на сервер для создания заказа.
@JsonSerializable()
class OrderPlacingInfoDto extends Equatable {
  const OrderPlacingInfoDto({
    required this.deliveryDate,
    required this.deliverySlotStart,
    required this.deliverySlotEnd,
    required this.description,
    required this.paymentMethod,
    required this.locationId,
  });

  /// Дата в формате `2024-06-15T00:00:00`.
  @JsonKey(name: 'DATE')
  final String deliveryDate;

  @JsonKey(name: 'TIME_BEGIN')
  final String deliverySlotStart;

  @JsonKey(name: 'TIME_END')
  final String deliverySlotEnd;

  @JsonKey(name: 'LOCATION')
  final String locationId;

  @JsonKey(name: 'DESCRIPTION')
  final String description;

  @JsonKey(name: 'PAYMENT_TYPE')
  final String paymentMethod;

  Map<String, dynamic> toJson() => _$OrderPlacingInfoDtoToJson(this);

  @override
  List<Object?> get props => [
        deliveryDate,
        deliverySlotStart,
        deliverySlotEnd,
        description,
        paymentMethod,
        locationId,
      ];
}
