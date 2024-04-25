import 'package:drift/drift.dart';
import 'package:niagara_app/core/utils/database/app_database.dart';
import 'package:niagara_app/features/location/data/cities/local/tables/cities_table.dart';

part 'cities_dao.g.dart';

/// DAO для работы с таблицей городов. Позволяет выполнять CRUD операции.
@DriftAccessor(tables: [CitiesTable])
class AllCities extends DatabaseAccessor<AppDatabase> with _$AllCitiesMixin {
  AllCities(super.attachedDatabase);

  Future<List<CitiesTableData>> getCities() async => select(citiesTable).get();

  Future<int> insertCity(CitiesTableCompanion companion) =>
      into(citiesTable).insert(companion);

  Future<void> updateCity(CitiesTableCompanion companion) =>
      update(citiesTable).replace(companion);

  Future<int> deleteCity(CitiesTableCompanion companion) =>
      delete(citiesTable).delete(companion);

  Future<void> clearCities() => delete(citiesTable).go();
}
