import 'package:drift/drift.dart';
import 'package:niagara_app/core/utils/enums/location_precision.dart';

/// Таблица местоположения для доставки в базе данных
class AddressesTable extends Table {
  IntColumn get id => integer()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  TextColumn get province => text()();
  TextColumn get locality => text()();
  TextColumn get district => text()();
  TextColumn get street => text()();
  TextColumn get house => text()();
  TextColumn get flat => text()();
  TextColumn get entrance => text()();
  TextColumn get floor => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  IntColumn get precision => intEnum<LocationPrecision>()();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  TextColumn get locationId => text()();

  @override
  Set<Column> get primaryKey => {id};
}
