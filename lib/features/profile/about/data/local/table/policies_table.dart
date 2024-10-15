import 'package:drift/drift.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';

class PoliciesTable extends Table {
  TextColumn get html => text()();
  TextColumn get type => text()();

  @override
  Set<Column> get primaryKey => {type};

  @override
  String get tableName => 'policies_table';
}
