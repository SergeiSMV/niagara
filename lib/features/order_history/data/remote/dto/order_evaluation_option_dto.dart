import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/core.dart';

part 'order_evaluation_option_dto.g.dart';

@JsonSerializable(createToJson: false)
class OrderEvaluationOptionDto extends Equatable {
  const OrderEvaluationOptionDto({
    required this.id,
    required this.name,
  });

  factory OrderEvaluationOptionDto.fromJson(Map<String, dynamic> json) =>
      _$OrderEvaluationOptionDtoFromJson(json);

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
