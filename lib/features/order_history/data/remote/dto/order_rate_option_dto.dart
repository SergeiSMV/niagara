import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/core.dart';

part 'order_rate_option_dto.g.dart';

@JsonSerializable(createToJson: false)
class OrderRateOptionDto extends Equatable {
  const OrderRateOptionDto({
    required this.id,
    required this.name,
  });

  factory OrderRateOptionDto.fromJson(Map<String, dynamic> json) =>
      _$OrderRateOptionDtoFromJson(json);

  @JsonKey(name: 'ID')
  final String id;
  @JsonKey(name: 'NAME')
  final String name;

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
