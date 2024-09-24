// ignore_for_file: sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/core.dart';

part 'pagination_dto.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.screamingSnake)
class PaginationDto extends Equatable {
  const PaginationDto({
    required this.current,
    required this.total,
    required this.items,
  });

  final int current;
  final int total;
  final int items;

  factory PaginationDto.fromJson(Map<String, dynamic> json) =>
      _$PaginationDtoFromJson(json);

  @override
  List<Object?> get props => [current, total];
}
