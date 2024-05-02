import 'package:drift/drift.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/data/shops/local/tables/shops_table.dart';

part 'shops_dao.g.dart';

/// DAO для работы с таблицей магазинов. Позволяет выполнять CRUD операции.
@DriftAccessor(tables: [ShopsTable])
class AllShops extends DatabaseAccessor<AppDatabase> with _$AllShopsMixin {
  AllShops(super.attachedDatabase);

  Future<List<ShopsTableData>> getShops() async => select(shopsTable).get();

  Future<void> insertShops(
    List<ShopsTableCompanion> companions,
  ) async =>
      batch((batch) => batch.insertAll(shopsTable, companions));

  Future<int> insertShop(ShopsTableCompanion companion) =>
      into(shopsTable).insert(companion);

  Future<void> updateShop(ShopsTableCompanion companion) =>
      update(shopsTable).replace(companion);

  Future<int> deleteShop(ShopsTableCompanion companion) =>
      delete(shopsTable).delete(companion);

  Future<void> clearShops() => delete(shopsTable).go();
}
