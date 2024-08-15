// ignore_for_file: sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/core.dart';

part 'order_draft_info_dto.g.dart';

/// DTO объекта, содержащий статус создания заказа и информацию для токенизации
/// ЮКасса.
@JsonSerializable()
class OrderDraftInfoDto extends Equatable {
  const OrderDraftInfoDto({
    required this.status,
    required this.tokenizationData,
  });

  @JsonKey(name: 'success')
  final bool status;

  @JsonKey(name: 'order')
  final TokenizationDataDto tokenizationData;

  factory OrderDraftInfoDto.fromJson(Map<String, dynamic> json) =>
      _$OrderDraftInfoDtoFromJson(json);

  @override
  List<Object?> get props => [status, tokenizationData];
}

@JsonSerializable()
class TokenizationDataDto extends Equatable {
  const TokenizationDataDto({
    required this.orderId,
    required this.shopId,
    required this.applicationKey,
    required this.title,
    required this.description,
    required this.customerId,
  });

  @JsonKey(name: 'ORDERD_ID')
  final String orderId;

  @JsonKey(name: 'YOOKASSA_SHOPID')
  final String shopId;

  @JsonKey(name: 'YOOKASSA_SECRETKEY')
  final String applicationKey;

  @JsonKey(name: 'ORDERD_HEAD')
  final String title;

  @JsonKey(name: 'ORDERD_DESCRIPTION')
  final String description;

  @JsonKey(name: 'CUSTOMER_ID')
  final String customerId;

  factory TokenizationDataDto.fromJson(Map<String, dynamic> json) =>
      _$TokenizationDataDtoFromJson(json);

  @override
  List<Object?> get props => [
        orderId,
        shopId,
        applicationKey,
        title,
        description,
        customerId,
      ];
}
