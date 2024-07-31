// ignore_for_file: sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/core.dart';
part 'referral_item_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class ReferralItemDto extends Equatable {
  final String text;
  final String? image;

  @override
  List<Object?> get props => [text, image];

  const ReferralItemDto({
    required this.text,
    required this.image,
  });

  factory ReferralItemDto.fromJson(Map<String, dynamic> json) =>
      _$ReferralItemDtoFromJson(json);
}
