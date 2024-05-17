import 'package:drift/drift.dart';
import 'package:niagara_app/core/common/data/database/app_database.dart';
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
      );
}

extension BottlesMapper on Bottles {
  BottlesEntity toEntity() => BottlesEntity(
        bottles: bottles.map((bottle) => bottle.toEntity()).toList(),
        count: count,
      );
}

extension BottleMapper on Bottle {
  BottleEntity toEntity() => BottleEntity(
        productId: id,
        name: name,
        count: count,
        offersId: offersId,
      );
}

extension BottleEntityMapper on BottleEntity {
  Bottle toModel() => Bottle(
        id: productId,
        name: name,
        count: count,
        offersId: offersId,
      );
}

extension BottlesEntityMapper on BottlesEntity {
  Bottles toModel() => Bottles(
        count: count,
        bottles: bottles.map((bottle) => bottle.toModel()).toList(),
      );
}
