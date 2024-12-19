import 'package:drift/drift.dart';
import 'package:niagara_app/core/common/data/database/app_database.dart';
import 'package:niagara_app/core/common/data/mappers/product_mapper.dart';
import 'package:niagara_app/core/core.dart';
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
        bottles: bottles.toModel(),
        bottlesGroupId: bottlesGroupId,
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
        bottles: Value(bottles),
        bottlesGroupId: Value(bottlesGroupId),
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
        bottles: bottles.toEntity(),
        bottlesGroupId: bottlesGroupId,
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
        bottles: bottles,
        bottlesGroupId: bottlesGroupId,
      );
}

extension BottlesMapper on Bottles {
  BottlesEntity toEntity() => BottlesEntity(
        bottles: bottles.map((bottle) => bottle.toEntity()).toList(),
        count: count,
      );
}

extension BottlesEntityMapper on BottlesEntity {
  Bottles toModel() => Bottles(
        count: count,
        bottles: bottles.map((bottle) => bottle.toModel()).toList(),
      );
}
