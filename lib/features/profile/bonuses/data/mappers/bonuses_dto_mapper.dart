import 'package:niagara_app/core/common/data/mappers/product_mapper.dart';
import 'package:niagara_app/core/utils/enums/status_level_type.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses.dart';
import 'package:niagara_app/features/profile/user/data/remote/dto/profile_dto.dart';

extension BonusesDtoMapper on ProfileDto {
  Bonuses toBonusesModel() => Bonuses(
        id: id.hashCode,
        cardNumber: bonusesCardNumber ?? '',
        count: int.parse(bonusesCount ?? '0'),
        tempCount: int.parse(bonusesTempCount ?? '0'),
        tempLastDate: bonusesTempLastDate ?? '',
        tempDays: int.parse(bonusesTempDays ?? '0'),
        level: StatusLevel.parseStatusLevel(bonusesLevel?.toLowerCase() ?? ''),
        nextLevel: StatusLevel.parseStatusLevel(bonusesLevelNext ?? ''),
        endDate: (bonusesLevelEnd != null
                ? DateTime.tryParse(bonusesLevelEnd!)
                : null) ??
            DateTime.now(),
        revThisMonth: revThisMonth ?? 0,
        bottles: Bottles(
          count: bottlesCount ?? 0,
          bottles: bottles?.map((bottle) => bottle.toModel()).toList() ?? [],
        ),
      );
}
