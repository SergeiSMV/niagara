import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:niagara_app/core/utils/enums/status_level_type.dart';
import 'package:niagara_app/features/profile/bonuses/data/local/entities/bonuses_entity.dart';

class BonusesTable extends Table {
  IntColumn get id => integer()();
  TextColumn get cardNumber => text()();
  IntColumn get count => integer()();
  IntColumn get tempCount => integer()();
  TextColumn get tempLastDate => text()();
  IntColumn get tempDays => integer()();
  IntColumn get level => intEnum<StatusLevel>()();
  IntColumn get nextLevel => intEnum<StatusLevel>()();
  DateTimeColumn get endDate => dateTime()();
  IntColumn get revThisMonth => integer()();
  TextColumn get bottles => text().map(const BottlesEntityConverter())();

  @override
  Set<Column> get primaryKey => {id};
}

class BottlesEntityConverter extends TypeConverter<BottlesEntity, String> {
  const BottlesEntityConverter();

  @override
  BottlesEntity fromSql(String fromDb) {
    if (fromDb.isEmpty) return const BottlesEntity(count: 0, bottles: []);

    return BottlesEntity.fromJson(jsonDecode(fromDb) as Map<String, dynamic>);
  }

  @override
  String toSql(BottlesEntity value) => jsonEncode(value.toJson());
}

class BottleEntityConverter extends TypeConverter<List<BottleEntity>, String> {
  const BottleEntityConverter();

  @override
  List<BottleEntity> fromSql(String fromDb) {
    if (fromDb.isEmpty) return [];

    return (jsonDecode(fromDb) as List)
        .map((e) => BottleEntity.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  String toSql(List<BottleEntity> value) =>
      jsonEncode(value.map((e) => e.toJson()).toList());
}
