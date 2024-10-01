import 'package:niagara_app/features/profile/referral_program/data/remote/dto/referral_code_data_dto.dart';
import 'package:niagara_app/features/profile/referral_program/data/remote/dto/referral_description_dto.dart';
import 'package:niagara_app/features/profile/referral_program/data/remote/dto/referral_history_item_dto.dart';
import 'package:niagara_app/features/profile/referral_program/data/remote/dto/referral_item_dto.dart';
import 'package:niagara_app/features/profile/referral_program/domain/model/referral_code_data.dart';
import 'package:niagara_app/features/profile/referral_program/domain/model/referral_description.dart';
import 'package:niagara_app/features/profile/referral_program/domain/model/referral_history.dart';
import 'package:niagara_app/features/profile/referral_program/domain/model/referral_item.dart';

extension ReferralDescriptionMapper on ReferralDescriptionDto {
  ReferralDescription toModel() {
    return ReferralDescription(
      description: description,
      bonusesMe: bonusesMe,
      bonusesFriend: bonusesFriend,
      bonusesFriendCount: bonusesFriendCount,
      bonusesForCount: bonusesForCount,
      bonusesConditionCount: bonusesConditionCount,
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

extension ReferralCodeDataMapper on ReferralCodeDataDto {
  ReferralCodeData toModel() {
    return ReferralCodeData(
      code: code,
      message: message,
    );
  }
}
