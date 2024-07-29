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

  /// Бонусов приглащающему за каждого друга.
  final int bonusesMe;

  /// Бонусов приглашенному другу.
  final int bonusesFriend;

  /// Количество приглашенных друзей.
  final int bonusesFriendCount;

  /// Количество бонусов за [bonusesConditionCount] приглашенных друзей.
  final int bonusesForCount;

  /// Количество приглашенных друзей, необходимое для получения
  /// [bonusesForCount] бонусов.
  final int bonusesConditionCount;

  /// Список условий реферальной программы.
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
