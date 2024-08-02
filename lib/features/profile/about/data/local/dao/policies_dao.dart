import 'package:niagara_app/core/common/data/database/_imports.dart';
import 'package:niagara_app/core/common/data/database/app_database.dart';
import 'package:niagara_app/features/profile/about/data/local/table/policies_table.dart';

part 'policies_dao.g.dart';

@DriftAccessor(tables: [PoliciesTable])
class AllPolicies extends DatabaseAccessor<AppDatabase>
    with _$AllPoliciesMixin {
  AllPolicies(super.attachedDatabase);

  Future<PoliciesTableData?> getPolicy(String type) async =>
      (select(policiesTable)..where((tbl) => tbl.type.equals(type)))
          .getSingleOrNull();

  Future<int> insertPolicy(PoliciesTableCompanion companion) =>
      into(policiesTable).insert(companion, mode: InsertMode.insertOrReplace);
}
