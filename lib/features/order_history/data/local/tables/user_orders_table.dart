import 'dart:convert';

import 'package:niagara_app/core/common/data/database/_imports.dart';

class UserOrdersTable extends Table {
  TextColumn get id => text()();
  TextColumn get orderNumber => text()();
  DateTimeColumn get dateDelivery => dateTime()();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get timeBegin => dateTime()();
  DateTimeColumn get timeEnd => dateTime()();
  TextColumn get customerName => text()();
  TextColumn get customerPhone => text()();
  TextColumn get locationId => text()();
  TextColumn get locationName => text()();
  TextColumn get description => text()();
  RealColumn get sumDelivery => real()();
  RealColumn get sumDiscont => real()();
  TextColumn get promoCode => text()();
  RealColumn get promoCodeSum => real()();
  IntColumn get taraCount => integer()();
  RealColumn get taraSum => real()();
  RealColumn get bonusesAdd => real()();
  RealColumn get bonusesPay => real()();
  IntColumn get orderStatus => intEnum<OrderStatus>()();
  IntColumn get orderProductsCount => integer()();
  RealColumn get orderProductsSum => real()();
  RealColumn get totalBenefit => real()();
  RealColumn get totalSum => real()();
  IntColumn get rating => integer()();
  TextColumn get ratingDescription => text()();
  BoolColumn get orderAgain => boolean()();
  IntColumn get paymentType => intEnum<OrdersPaymentTypes>()();
  BoolColumn get paymentCompleted => boolean()();
  TextColumn get products => text().map(const ProductsEntityConverter())();

  @override
  Set<Column> get primaryKey => {id};
}

class ProductsEntityConverter
    extends TypeConverter<List<ProductEntity>, String> {
  const ProductsEntityConverter();

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
