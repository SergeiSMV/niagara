import 'package:drift/drift.dart';

class PoliciesTable extends Table {
  TextColumn get html => text()();
  TextColumn get type => text()();

  @override
  Set<Column> get primaryKey => {type};
}
