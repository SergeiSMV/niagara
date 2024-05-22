// ignore_for_file: sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/core.dart';

part 'pagination_dto.g.dart';

@JsonSerializable(createToJson: false)
class PaginationDto extends Equatable {
  const PaginationDto({
    required this.current,
    required this.total,
  });

  @JsonKey(name: 'CURRENT')
  final int current;

  @JsonKey(name: 'TOTAL')
  final int total;

  factory PaginationDto.fromJson(Map<String, dynamic> json) =>
      _$PaginationDtoFromJson(json);

  @override
  List<Object?> get props => [current, total];
}
