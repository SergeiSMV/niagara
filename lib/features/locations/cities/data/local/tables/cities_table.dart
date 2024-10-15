import 'package:drift/drift.dart';

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
  String get tableName => 'cities_table';
}
