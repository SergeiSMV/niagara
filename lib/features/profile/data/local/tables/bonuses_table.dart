import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:niagara_app/core/utils/enums/bonus_level_type.dart';
import 'package:niagara_app/features/profile/data/local/entities/bonuses_entity.dart';

class BonusesTable extends Table {
  IntColumn get id => integer()();
  TextColumn get cardNumber => text()();
  IntColumn get count => integer()();
  IntColumn get tempCount => integer()();
  TextColumn get tempLastDate => text()();
  IntColumn get tempDays => integer()();
  IntColumn get level => intEnum<BonusLevel>()();
  IntColumn get nextLevel => intEnum<BonusLevel>()();
  DateTimeColumn get endDate => dateTime()();
  IntColumn get revThisMonth => integer()();
  TextColumn get bonuses => text().map(const BonusEntityConverter())();

  @override
  Set<Column> get primaryKey => {id};
}

class BonusEntityConverter extends TypeConverter<List<BonusEntity>, String> {
  const BonusEntityConverter();

  @override
  List<BonusEntity> fromSql(String fromDb) {
    if (fromDb.isEmpty) return [];

    return (jsonDecode(fromDb) as List)
        .map((e) => BonusEntity.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  String toSql(List<BonusEntity> value) =>
      jsonEncode(value.map((e) => e.toJson()).toList());
}
