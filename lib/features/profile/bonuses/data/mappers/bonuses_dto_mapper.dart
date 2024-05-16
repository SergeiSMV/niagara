import 'package:niagara_app/core/utils/enums/status_level_type.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses.dart';
import 'package:niagara_app/features/profile/user/data/remote/dto/profile_dto.dart';

extension BonusesDtoMapper on ProfileDto {
  Bonuses toBonusesModel() => Bonuses(
        id: id.hashCode,
        cardNumber: bonusesCardNumber,
        count: bonusesCount,
        tempCount: bonusesTempCount,
        tempLastDate: bonusesTempLastDate,
        tempDays: bonusesTempDays,
        level: StatusLevel.fromString(bonusesLevel),
        nextLevel: StatusLevel.fromString(bonusesLevelNext),
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
