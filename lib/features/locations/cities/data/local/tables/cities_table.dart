import 'package:drift/drift.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';

/// Таблица городов для работы с базой данных
class CitiesTable extends Table {
  IntColumn get id => integer()();
  TextColumn get province => text()();
  TextColumn get locality => text()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  TextColumn get phone => text()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => AppConstants.kCitiesTable;
}
