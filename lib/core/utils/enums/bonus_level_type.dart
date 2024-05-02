import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

enum BonusLevel {
  silver,
  gold,
  platinum;

  static BonusLevel fromString(String value) => switch (value) {
        'silver' => BonusLevel.silver,
        'gold' => BonusLevel.gold,
        'platinum' => BonusLevel.platinum,
        _ => BonusLevel.silver
      };

  String toLocale() => switch (this) {
        BonusLevel.silver => t.bonuses.levels.silver,
        BonusLevel.gold => t.bonuses.levels.gold,
        BonusLevel.platinum => t.bonuses.levels.platinum,
      };

  AssetGenImage get cardImage => switch (this) {
        BonusLevel.silver => Assets.images.bonusStatus.silver,
        BonusLevel.gold => Assets.images.bonusStatus.gold,
        BonusLevel.platinum => Assets.images.bonusStatus.platinum,
      };
}
