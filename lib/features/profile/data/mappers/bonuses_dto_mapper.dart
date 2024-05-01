import 'package:niagara_app/core/utils/enums/bonus_level_type.dart';
import 'package:niagara_app/features/profile/data/remote/dto/profile_dto.dart';
import 'package:niagara_app/features/profile/domain/models/bonuses.dart';

extension BonusesDtoMapper on ProfileDto {
  Bonuses toBonusesModel() => Bonuses(
        id: id.hashCode,
        cardNumber: bonusesCardNumber,
        count: bonusesCount,
        tempCount: bonusesTempCount,
        tempLastDate: bonusesTempLastDate,
        tempDays: bonusesTempDays,
        level: BonusLevel.fromString(bonusesLevel),
        nextLevel: BonusLevel.fromString(bonusesLevelNext),
        endDate: bonusesDateEnd,
        revThisMonth: revThisMonth,
        bonuses: bonuses.map((bonus) => bonus.toModel()).toList(),
      );
}

extension BonusDtoMapper on BonusDto {
  Bonus toModel() => Bonus(
        programId: bonusProgramId,
        isTemp: bonusTemp,
        endDate: bonusDateEnd,
        count: bonusCount,
      );
}
