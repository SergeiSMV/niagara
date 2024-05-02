import 'package:drift/drift.dart';
import 'package:niagara_app/core/common/data/database/app_database.dart';
import 'package:niagara_app/features/profile/bonuses/data/local/entities/bonuses_entity.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses.dart';

extension BonusesEntityMapper on BonusesEntity {
  Bonuses toModel() => Bonuses(
        id: id,
        cardNumber: cardNumber,
        count: count,
        tempCount: tempCount,
        tempLastDate: tempLastDate,
        tempDays: tempDays,
        level: level,
        nextLevel: nextLevel,
        endDate: endDate,
        revThisMonth: revThisMonth,
        bonuses: bonuses.map((bonusEntity) => bonusEntity.toEntity()).toList(),
      );

  BonusesTableCompanion toCompanion() => BonusesTableCompanion(
        id: Value(id),
        cardNumber: Value(cardNumber),
        count: Value(count),
        tempCount: Value(tempCount),
        tempLastDate: Value(tempLastDate),
        tempDays: Value(tempDays),
        level: Value(level),
        nextLevel: Value(nextLevel),
        endDate: Value(endDate),
        revThisMonth: Value(revThisMonth),
        bonuses: Value(bonuses),
      );
}

extension BonusesMapper on Bonuses {
  BonusesEntity toEntity() => BonusesEntity(
        id: id,
        cardNumber: cardNumber,
        count: count,
        tempCount: tempCount,
        tempLastDate: tempLastDate,
        tempDays: tempDays,
        level: level,
        nextLevel: nextLevel,
        endDate: endDate,
        revThisMonth: revThisMonth,
        bonuses: bonuses.map((bonus) => bonus.toEntity()).toList(),
      );
}

extension BonusesTableMapper on BonusesTableData {
  BonusesEntity toEntity() => BonusesEntity(
        id: id,
        cardNumber: cardNumber,
        count: count,
        tempCount: tempCount,
        tempLastDate: tempLastDate,
        tempDays: tempDays,
        level: level,
        nextLevel: nextLevel,
        endDate: endDate,
        revThisMonth: revThisMonth,
        bonuses: bonuses,
      );
}

extension BonusMapper on Bonus {
  BonusEntity toEntity() => BonusEntity(
        programId: programId,
        isTemp: isTemp,
        endDate: endDate,
        count: count,
      );
}

extension BonusEntityMapper on BonusEntity {
  Bonus toEntity() => Bonus(
        programId: programId,
        isTemp: isTemp,
        endDate: endDate,
        count: count,
      );
}
