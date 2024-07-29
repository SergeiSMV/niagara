// ignore_for_file: sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/referral_program/data/remote/dto/referral_item_dto.dart';

part 'referral_description_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class ReferralDescriptionDto extends Equatable {
  final String description;
  final int bonusesMe;
  final int bonusesFriend;
  final int bonusesFriendCount;
  final int bonusesForCount;
  final int bonusesConditionCount;
  final List<ReferralItemDto> items;

  @override
  List<Object?> get props => [
        description,
        bonusesMe,
        bonusesFriend,
        bonusesFriendCount,
        bonusesForCount,
        bonusesConditionCount,
      ];

  const ReferralDescriptionDto({
    required this.description,
    required this.bonusesMe,
    required this.bonusesFriend,
    required this.bonusesFriendCount,
    required this.bonusesForCount,
    required this.bonusesConditionCount,
    required this.items,
  });

  factory ReferralDescriptionDto.fromJson(Map<String, dynamic> json) =>
      _$ReferralDescriptionDtoFromJson(json);
}
