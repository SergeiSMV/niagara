import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/data/locations/local/entities/location_entity.dart';
import 'package:niagara_app/features/location/data/locations/mappers/location_entity_mapper.dart';

/// Интерфейс для работы с локациями в локальной базе данных.
abstract interface class ILocationsLocalDatasource {
  Future<Either<Failure, List<LocationEntity>>> getLocations();

  Future<Either<Failure, void>> saveLocations(List<LocationEntity> locations);

  Future<Either<Failure, void>> addLocation(LocationEntity location);

  Future<Either<Failure, void>> updateLocation(LocationEntity location);

  Future<Either<Failure, void>> deleteLocation(LocationEntity location);
}

@LazySingleton(as: ILocationsLocalDatasource)
class LocationsLocalDatasource implements ILocationsLocalDatasource {
  LocationsLocalDatasource({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  @override
  Future<Either<Failure, List<LocationEntity>>> getLocations() => _execute(
        () async => (await _database.allLocations.getLocations())
            .map((table) => table.toEntity())
            .toList(),
      );

  @override
  Future<Either<Failure, void>> saveLocations(List<LocationEntity> locations) =>
      _execute(
        () => _database.allLocations.insertLocations(
          locations.map((entity) => entity.toCompanion()).toList(),
        ),
      );

  @override
  Future<Either<Failure, void>> addLocation(LocationEntity location) =>
      _execute(
        () => _database.allLocations.insertLocation(location.toCompanion()),
      );

  @override
  Future<Either<Failure, void>> updateLocation(LocationEntity location) =>
      _execute(
        () => _database.allLocations.updateLocation(location.toCompanion()),
      );

  @override
  Future<Either<Failure, void>> deleteLocation(LocationEntity location) =>
      _execute(
        () => _database.allLocations.deleteLocation(location.toCompanion()),
      );

  Future<Either<Failure, T>> _execute<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return Right(result);
    } catch (e) {
      return Left(LocationsLocalDataFailure(e.toString()));
    }
  }
}
