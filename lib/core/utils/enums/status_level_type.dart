import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Различные статусы аккаунта.
enum StatusLevel {
  silver,
  gold,
  platinum,
  vip,
  partner,
  employee,
  social;

  static StatusLevel parseStatusLevel(String value) => switch (value) {
        'silver' => StatusLevel.silver,
        'gold' => StatusLevel.gold,
        'platinum' => StatusLevel.platinum,
        'vip' => StatusLevel.vip,
        'partner' => StatusLevel.partner,
        'np' => StatusLevel.employee,
        'social' => StatusLevel.social,
        _ => StatusLevel.silver
      };

  String get convertStatusLevelToString => switch (this) {
        StatusLevel.employee => 'np',
        _ => name,
      };

  String get toLocale => switch (this) {
        StatusLevel.silver => t.bonuses.levels.silver,
        StatusLevel.gold => t.bonuses.levels.gold,
        StatusLevel.platinum => t.bonuses.levels.platinum,
        StatusLevel.vip => t.bonuses.levels.vip,
        StatusLevel.partner => t.bonuses.levels.partner,
        StatusLevel.employee => t.bonuses.levels.employer,
        StatusLevel.social => t.bonuses.levels.social,
      };

  AssetGenImage get cardImage => switch (this) {
        StatusLevel.silver => Assets.images.bonusStatus.silver,
        StatusLevel.gold => Assets.images.bonusStatus.gold,
        StatusLevel.platinum => Assets.images.bonusStatus.platinum,
        StatusLevel.vip => Assets.images.bonusStatus.statusVIP,
        StatusLevel.partner => Assets.images.bonusStatus.partner,
        StatusLevel.employee => Assets.images.bonusStatus.employer,
        StatusLevel.social => Assets.images.bonusStatus.social,
      };

  AssetGenImage get statusIcon => switch (this) {
        StatusLevel.partner => Assets.images.aboutBonuses.briefcase,
        StatusLevel.employee => Assets.images.aboutBonuses.staff,
        StatusLevel.social => Assets.images.aboutBonuses.social,
        _ => Assets.images.aboutBonuses.social,
      };

  bool get isBasicStatus =>
      this == StatusLevel.silver ||
      this == StatusLevel.gold ||
      this == StatusLevel.platinum;

  bool get isSpecialStatus =>
      this == StatusLevel.partner ||
      this == StatusLevel.employee ||
      this == StatusLevel.social;

  bool get isVIPStatus => this == StatusLevel.vip;
}

enum BenefitPicture {
  coin,
  cashback;

  static BenefitPicture fromString(String value) => switch (value) {
        'coin' => BenefitPicture.coin,
        'cashback' => BenefitPicture.cashback,
        _ => BenefitPicture.coin
      };

  SvgGenImage get picture => switch (this) {
        BenefitPicture.coin => Assets.icons.coinNiagara,
        BenefitPicture.cashback => Assets.icons.cashback,
      };
}
