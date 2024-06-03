import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

enum StatusLevel {
  silver,
  gold,
  platinum,
  vip,
  partner,
  employer, 
  social;

  static StatusLevel fromString(String value) => switch (value) {
        'silver' => StatusLevel.silver,
        'gold' => StatusLevel.gold,
        'platinum' => StatusLevel.platinum,
        'vip' => StatusLevel.vip,
        'corp' => StatusLevel.partner,
        'np' => StatusLevel.employer,
        'social' => StatusLevel.social,
        _ => StatusLevel.silver
      };

  String toLocale() => '${switch (this) {
        StatusLevel.silver => t.bonuses.levels.silver,
        StatusLevel.gold => t.bonuses.levels.gold,
        StatusLevel.platinum => t.bonuses.levels.platinum,
        StatusLevel.vip => t.bonuses.levels.vip,
        StatusLevel.partner => t.bonuses.levels.partner,
        StatusLevel.employer => t.bonuses.levels.employer,
        StatusLevel.social => t.bonuses.levels.social,
      }} ${t.bonuses.status.toLowerCase()}';

  AssetGenImage get cardImage => switch (this) {
        StatusLevel.silver => Assets.images.bonusStatus.silver,
        StatusLevel.gold => Assets.images.bonusStatus.gold,
        StatusLevel.platinum => Assets.images.bonusStatus.platinum,
        StatusLevel.vip => Assets.images.bonusStatus.statusVIP,
        StatusLevel.partner => Assets.images.bonusStatus.partner,
        StatusLevel.employer => Assets.images.bonusStatus.employer,
        StatusLevel.social => Assets.images.bonusStatus.social,
      };
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
