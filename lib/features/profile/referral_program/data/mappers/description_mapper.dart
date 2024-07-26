import 'package:niagara_app/features/profile/referral_program/data/remote/dto/referral_description_dto.dart';
import 'package:niagara_app/features/profile/referral_program/data/remote/dto/referral_history_item_dto.dart';
import 'package:niagara_app/features/profile/referral_program/data/remote/dto/referral_item_dto.dart';
import 'package:niagara_app/features/profile/referral_program/domain/model/referral_description.dart';
import 'package:niagara_app/features/profile/referral_program/domain/model/referral_history.dart';
import 'package:niagara_app/features/profile/referral_program/domain/model/referral_item.dart';

extension ReferralDescriptionMapper on ReferralDescriptionDto {
  ReferralDescription toModel() {
    return ReferralDescription(
      description: description,
      bonusesMe: bonusesMe.toString(),
      bonusesFriend: bonusesFriend.toString(),
      bonusesFriendCount: bonusesFriendCount.toString(),
      bonusesForCount: bonusesForCount.toString(),
      bonusesConditionCount: bonusesConditionCount.toString(),
      items: items.map((e) => e.toModel()).toList(),
    );
  }
}

extension ReferralItemMapper on ReferralItemDto {
  ReferralItem toModel() {
    return ReferralItem(
      text: text,
    );
  }
}

extension ReferralHistoryMapper on ReferralHistoryItemDto {
  ReferralHistoryItem toModel() {
    return ReferralHistoryItem(
      friendCount: friendCount,
      friendDate: friendDate,
      friendName: friendName,
      friendPhone: friendPhone,
    );
  }
}
