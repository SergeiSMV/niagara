import 'package:drift/drift.dart';
import 'package:niagara_app/core/utils/database/auto_incrementing_key_mixin.dart';
import 'package:niagara_app/core/utils/enums/location_precision.dart';

@DataClassName('LocationTable')
class Locations extends Table with AutoIncrementingPrimaryKey {
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  TextColumn get province => text()();
  TextColumn get city => text()();
  TextColumn get locality => text()();
  TextColumn get district => text()();
  TextColumn get street => text()();
  TextColumn get house => text()();
  TextColumn get floor => text()();
  TextColumn get flat => text()();
  TextColumn get entrance => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get deliveryId => text().nullable()();
  DateTimeColumn get serviceLastDate => dateTime().nullable()();
  DateTimeColumn get serviceNextDate => dateTime().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get precision => intEnum<LocationPrecision>()();
  BoolColumn get isPrimary => boolean().withDefault(const Constant(false))();
}
