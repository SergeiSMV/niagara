import 'package:niagara_app/core/utils/gen/strings.g.dart';

enum BonusLevel {
  none,
  silver,
  gold,
  platinum;

  static BonusLevel fromString(String value) => switch (value) {
        'silver' => BonusLevel.silver,
        'gold' => BonusLevel.gold,
        'platinum' => BonusLevel.platinum,
        _ => BonusLevel.none
      };

  String toLocale() => switch (this) {
        BonusLevel.silver => t.bonuses.levels.silver,
        BonusLevel.gold => t.bonuses.levels.gold,
        BonusLevel.platinum => t.bonuses.levels.platinum,
        _ => t.bonuses.levels.none
      };
}
