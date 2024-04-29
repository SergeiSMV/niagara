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
    extends TypeConverter<ShopWorkTimeEntity, String> {
  const ShopWorkTimeEntityConverter();

  @override
  ShopWorkTimeEntity fromSql(String fromDb) =>
      ShopWorkTimeEntity.fromJson(jsonDecode(fromDb) as Map<String, dynamic>);

  @override
  String toSql(ShopWorkTimeEntity value) => jsonEncode(value.toJson());
}
