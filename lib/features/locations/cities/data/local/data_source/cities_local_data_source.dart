import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/locations/cities/data/local/entities/city_entity.dart';
import 'package:niagara_app/features/locations/cities/data/mappers/city_entity_mapper.dart';

/// Интерфейс для работы с локальными данными города
abstract interface class ICitiesLocalDataSource {
  Future<Either<Failure, CityEntity>> getCity();

  Future<Either<Failure, void>> setCity(CityEntity city);
}

@LazySingleton(as: ICitiesLocalDataSource)
class CitiesLocalDatasource implements ICitiesLocalDataSource {
  CitiesLocalDatasource(this._database);

  final AppDatabase _database;

  @override
  Future<Either<Failure, CityEntity>> getCity() => _execute(
        () async {
          final cities = await _database.allCities.getCities();
          final city = cities.isNotEmpty ? cities.first : null;
          if (city == null) {
            throw const CitiesLocalDataFailure('City not found');
          }
          return city.toEntity();
        },
      );

  @override
  Future<Either<Failure, void>> setCity(CityEntity city) => _execute(
        () async {
          await _database.allCities.clearCities();
          await _database.allCities.insertCity(city.toCompanion());
        },
      );

  Future<Either<Failure, T>> _execute<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return Right(result);
    } on Failure catch (e) {
      return Left(CitiesLocalDataFailure(e.toString()));
    }
  }
}
