import 'package:drift/drift.dart';
import 'package:niagara_app/core/utils/database/app_database.dart';
import 'package:niagara_app/features/location/data/locations/local/tables/location_table.dart';

part 'location_dao.g.dart';

/// DAO для работы с таблицей локаций. Позволяет выполнять CRUD операции.
@DriftAccessor(tables: [LocationsTable])
class AllLocations extends DatabaseAccessor<AppDatabase>
    with _$AllLocationsMixin {
  AllLocations(super.attachedDatabase);

  Future<List<LocationsTableData>> getLocations() async =>
      select(locationsTable).get();

  Future<void> insertLocations(
    List<LocationsTableCompanion> companions,
  ) async =>
      batch((batch) => batch.insertAll(locationsTable, companions));

  Future<int> insertLocation(LocationsTableCompanion companion) =>
      into(locationsTable).insert(companion);

  Future<bool> updateLocation(LocationsTableCompanion companion) =>
      update(locationsTable).replace(companion);

  Future<int> deleteLocation(LocationsTableCompanion companion) =>
      delete(locationsTable).delete(companion);
}
