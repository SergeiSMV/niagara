import 'dart:convert';

import 'package:niagara_app/core/common/data/database/_imports.dart';

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
  TextColumn get bottlesGroupId => text().nullable()();

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

class BottleEntityConverter extends TypeConverter<List<ProductEntity>, String> {
  const BottleEntityConverter();

  @override
  List<ProductEntity> fromSql(String fromDb) {
    if (fromDb.isEmpty) return [];

    return (jsonDecode(fromDb) as List)
        .map((e) => ProductEntity.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  String toSql(List<ProductEntity> value) =>
      jsonEncode(value.map((e) => e.toJson()).toList());
}
