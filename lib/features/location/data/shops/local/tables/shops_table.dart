import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:niagara_app/features/location/data/shops/local/entities/shop_entity.dart';

class ShopsTable extends Table {
  IntColumn get id => integer()();
  TextColumn get province => text()();
  TextColumn get locality => text()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  TextColumn get workTime => text().map(const ShopWorkTimeEntityConverter())();

  @override
  Set<Column> get primaryKey => {id};
}

class ShopWorkTimeEntityConverter
    extends TypeConverter<List<ShopWorkTimeEntity>, String> {
  const ShopWorkTimeEntityConverter();

  @override
  List<ShopWorkTimeEntity> fromSql(String fromDb) {
    if (fromDb.isEmpty) return [];

    return (jsonDecode(fromDb) as List)
        .map((e) => ShopWorkTimeEntity.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  String toSql(List<ShopWorkTimeEntity> value) =>
      jsonEncode(value.map((e) => e.toJson()).toList());
}
