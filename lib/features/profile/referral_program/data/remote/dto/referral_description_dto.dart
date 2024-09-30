// ignore_for_file: sort_constructors_first

import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/referral_program/data/remote/dto/referral_item_dto.dart';

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
      ReferralDescriptionDto(
        description: json['description'] as String,
        bonusesMe: (json['bonuses_me'] as num).toInt(),
        bonusesFriend: (json['bonuses_friend'] as num).toInt(),
        bonusesFriendCount: (json['bonuses_friend_count'] as num).toInt(),
        bonusesForCount: (json['bonuses_for_count'] as num).toInt(),
        bonusesConditionCount: (json['bonuses_condition_count'] as num).toInt(),
        items: (json['items'] as List<dynamic>)
            .map((e) => ReferralItemDto.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
