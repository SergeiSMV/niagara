import 'package:drift/drift.dart';
import 'package:niagara_app/core/utils/database/auto_incrementing_key_mixin.dart';

@DataClassName('CitiesTable')
class Cities extends Table with AutoIncrementingPrimaryKey {
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  TextColumn get region => text()();
  TextColumn get city => text()();
}
