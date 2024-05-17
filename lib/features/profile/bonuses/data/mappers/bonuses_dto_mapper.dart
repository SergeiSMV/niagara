import 'package:niagara_app/core/utils/enums/status_level_type.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses.dart';
import 'package:niagara_app/features/profile/user/data/remote/dto/profile_dto.dart';

extension BonusesDtoMapper on ProfileDto {
  Bonuses toBonusesModel() => Bonuses(
        id: id.hashCode,
        cardNumber: bonusesCardNumber,
        count: int.parse(bonusesCount),
        tempCount: int.parse(bonusesTempCount),
        tempLastDate: bonusesTempLastDate,
        tempDays: int.parse(bonusesTempDays),
        level: StatusLevel.fromString(bonusesLevel),
        nextLevel: StatusLevel.fromString(bonusesLevelNext),
        endDate: bonusesDateEnd,
        revThisMonth: revThisMonth,
        bottles: Bottles(
          count: bottlesCount,
          bottles: bottles.map((bottle) => bottle.toModel()).toList(),
        ),
      );
}

extension BottleDtoMapper on BottlesDto {
  Bottle toModel() => Bottle(
        id: productId,
        name: productName,
        count: int.parse(count),
        offersId: offersId,
      );
}
