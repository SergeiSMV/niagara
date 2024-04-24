import 'package:drift/drift.dart';
import 'package:niagara_app/core/utils/database/app_database.dart';
import 'package:niagara_app/features/location/data/datasources/locations/local/location_drift_table.dart';
import 'package:niagara_app/features/location/data/mappers/table_to_model_location_mapper.dart';
import 'package:niagara_app/features/location/data/models/location_model.dart';

part 'location_drift_dao.g.dart';

@DriftAccessor(tables: [Locations])
class AllLocations extends DatabaseAccessor<AppDatabase>
    with _$AllLocationsMixin {
  AllLocations(super.attachedDatabase);

  Future<List<LocationModel>> getLocations() async {
    final locationTable = await select(locations).get();
    return locationTable.map((e) => e.toModel()).toList();
  }

  Future<void> insertLocations(List<LocationsCompanion> companions) async =>
      batch((batch) {
        batch.insertAll(locations, companions);
      });

  Future<int> insertLocation(LocationsCompanion companion) =>
      into(locations).insert(companion);

  Future<bool> updateLocation(LocationsCompanion companion) =>
      update(locations).replace(companion);

  Future<int> deleteLocation(LocationsCompanion companion) =>
      delete(locations).delete(companion);
}
