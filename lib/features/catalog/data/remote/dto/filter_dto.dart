// ignore_for_file: sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/core.dart';

part 'filter_dto.g.dart';

@JsonSerializable(createToJson: false)
class FilterDto extends Equatable {
  const FilterDto({
    required this.propertyId,
    required this.propertyName,
    required this.valueId,
    required this.valueName,
  });

  @JsonKey(name: 'PROPERTY_ID')
  final String propertyId;
  @JsonKey(name: 'PROPERTY_NAME')
  final String propertyName;
  @JsonKey(name: 'VALUE_ID')
  final String valueId;
  @JsonKey(name: 'VALUE_NAME')
  final String valueName;

  factory FilterDto.fromJson(Map<String, dynamic> json) =>
      _$FilterDtoFromJson(json);

  @override
  List<Object?> get props => [propertyId, propertyName, valueId, valueName];
}
