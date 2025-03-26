import 'package:drift/drift.dart';

class UsersTable extends Table {
  IntColumn get id => integer()();
  TextColumn get userId => text()();
  TextColumn get name => text()();
  TextColumn get surname => text()();
  TextColumn get patronymic => text()();
  TextColumn get login => text()();
  TextColumn get phone => text()();
  TextColumn get email => text()();
  TextColumn get birthday => text()();
  TextColumn get defaultLocationId => text()();
  IntColumn get ordersCount => integer().withDefault(const Constant(0))();
  @override
  Set<Column> get primaryKey => {id};
}
