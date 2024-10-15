import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/features/locations/shops/data/local/entities/shop_entity.dart';

class ShopsTable extends Table {
  IntColumn get id => integer()();
  TextColumn get province => text()();
  TextColumn get locality => text()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  IntColumn get storeDays => integer()();
  TextColumn get openTime => text()();
  TextColumn get closeTime => text()();
  TextColumn get schedule => text().map(const ShopWorkTimeEntityConverter())();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'shops_table';
}

class ShopWorkTimeEntityConverter
    extends TypeConverter<List<ShopScheduleEntity>, String> {
  const ShopWorkTimeEntityConverter();

  @override
  List<ShopScheduleEntity> fromSql(String fromDb) {
    if (fromDb.isEmpty) return [];

    return (jsonDecode(fromDb) as List)
        .map((e) => ShopScheduleEntity.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  String toSql(List<ShopScheduleEntity> value) =>
      jsonEncode(value.map((e) => e.toJson()).toList());
}
