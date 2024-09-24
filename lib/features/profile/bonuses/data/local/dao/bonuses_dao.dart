import 'package:drift/drift.dart';
import 'package:niagara_app/core/common/data/database/app_database.dart';
import 'package:niagara_app/features/profile/bonuses/data/local/tables/bonuses_table.dart';

part 'bonuses_dao.g.dart';

@DriftAccessor(tables: [BonusesTable])
class AllBonuses extends DatabaseAccessor<AppDatabase> with _$AllBonusesMixin {
  AllBonuses(super.attachedDatabase);

  Future<BonusesTableData> getBonuses() async =>
      select(bonusesTable).getSingle();

  Future<int> insertBonuses(BonusesTableCompanion companion) =>
      into(bonusesTable).insert(companion);

  Future<bool> updateBonuses(BonusesTableCompanion companion) =>
      update(bonusesTable).replace(companion);

  Future<int> deleteBonuses(BonusesTableCompanion companion) =>
      delete(bonusesTable).delete(companion);

  Future<int> clear() => delete(bonusesTable).go();
}
