import 'package:drift/drift.dart';
import 'package:niagara_app/core/utils/database/app_database.dart';
import 'package:niagara_app/features/location/data/datasources/cities/local/cities_table.dart';
import 'package:niagara_app/features/location/data/mappers/city_table_mapper.dart';
import 'package:niagara_app/features/location/data/models/city_model.dart';

part 'cities_dao.g.dart';

@DriftAccessor(tables: [Cities])
class AllCities extends DatabaseAccessor<AppDatabase> with _$AllCitiesMixin {
  AllCities(super.attachedDatabase);

  Future<List<CityModel>> getCities() async {
    final citiesTable = await select(cities).get();
    return citiesTable.map((e) => e.toModel()).toList();
  }

  Future<int> insertCity(CitiesCompanion companion) =>
      into(cities).insert(companion);

  Future<void> updateCity(CitiesCompanion companion) =>
      update(cities).replace(companion);

  Future<int> deleteCity(CitiesCompanion companion) =>
      delete(cities).delete(companion);

  Future<void> clearCities() => delete(cities).go();
}
