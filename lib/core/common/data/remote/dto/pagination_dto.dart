import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/core.dart';

part 'pagination_dto.g.dart';

@Equatable()
@JsonSerializable(createToJson: false)
class PaginationDto {
  PaginationDto({
    required this.current,
    required this.total,
  });

  @JsonKey(name: 'current')
  final int current;

  @JsonKey(name: 'total')
  final int total;

  factory PaginationDto.fromJson(Map<String, dynamic> json) =>
      _$PaginationDtoFromJson(json);
}
