import 'package:drift/drift.dart';
import 'package:niagara_app/core/common/data/database/app_database.dart';
import 'package:niagara_app/features/locations/addresses/data/local/tables/addresses_table.dart';

part 'addresses_dao.g.dart';

/// DAO для работы с таблицей адресов. Позволяет выполнять CRUD операции.
@DriftAccessor(tables: [AddressesTable])
class AllAddresses extends DatabaseAccessor<AppDatabase>
    with _$AllAddressesMixin {
  AllAddresses(super.attachedDatabase);

  Future<List<AddressesTableData>> getAddresses() async =>
      select(addressesTable).get();

  Future<void> insertAddresses(
    List<AddressesTableCompanion> companions,
  ) async =>
      batch(
        (batch) => batch.insertAll(
          addressesTable,
          companions,
          mode: InsertMode.insertOrReplace,
        ),
      );

  Future<int> insertAddress(AddressesTableCompanion companion) =>
      into(addressesTable).insert(companion);

  Future<bool> updateAddress(AddressesTableCompanion companion) =>
      update(addressesTable).replace(companion);

  Future<int> deleteAddress(AddressesTableCompanion companion) =>
      delete(addressesTable).delete(companion);
}
