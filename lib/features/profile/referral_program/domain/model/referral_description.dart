import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/referral_program/domain/model/referral_item.dart';

class ReferralDescription extends Equatable {
  const ReferralDescription({
    required this.description,
    required this.bonusesMe,
    required this.bonusesFriend,
    required this.bonusesFriendCount,
    required this.bonusesForCount,
    required this.bonusesConditionCount,
    required this.items,
  });

  final String description;
  final String bonusesMe;
  final String bonusesFriend;
  final String bonusesFriendCount;
  final String bonusesForCount;
  final String bonusesConditionCount;
  final List<ReferralItem> items;

  @override
  List<Object?> get props => [
        description,
        bonusesMe,
        bonusesFriend,
        bonusesFriendCount,
        bonusesForCount,
        bonusesConditionCount,
      ];
}
