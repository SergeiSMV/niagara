// ignore_for_file: sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/core.dart';

part 'promotion_dto.g.dart';

@JsonSerializable(createToJson: false)
class PromotionDto extends Equatable {
  const PromotionDto({
    this.id,
    this.name,
    this.description,
    this.image,
    this.dateBegin,
    this.dateEnd,
    this.personal,
  });

  @JsonKey(name: 'ID')
  final String? id;
  @JsonKey(name: 'NAME')
  final String? name;
  @JsonKey(name: 'DESCRIPTION')
  final String? description;
  @JsonKey(name: 'IMAGE')
  final String? image;
  @JsonKey(name: 'DATE_BEGIN')
  final String? dateBegin;
  @JsonKey(name: 'DATE_END')
  final String? dateEnd;
  @JsonKey(name: 'PERSONAL')
  final bool? personal;

  factory PromotionDto.fromJson(Map<String, dynamic> json) =>
      _$PromotionDtoFromJson(json);

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        image,
        dateBegin,
        dateEnd,
        personal,
      ];
}
