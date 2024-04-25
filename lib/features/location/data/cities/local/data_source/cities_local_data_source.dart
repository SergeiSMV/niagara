import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/data/cities/local/entities/city_entity.dart';
import 'package:niagara_app/features/location/data/cities/mappers/city_entity_mapper.dart';

/// Интерфейс для работы с локальными данными города
abstract interface class ICitiesLocalDatasource {
  Future<Either<Failure, CityEntity>> getCity();

  Future<Either<Failure, void>> setCity(CityEntity city);
}

@LazySingleton(as: ICitiesLocalDatasource)
class CitiesLocalDatasource implements ICitiesLocalDatasource {
  CitiesLocalDatasource({
    required AppDatabase database,
  }) : _database = database;

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
    } catch (e) {
      return Left(CitiesLocalDataFailure(e.toString()));
    }
  }
}
