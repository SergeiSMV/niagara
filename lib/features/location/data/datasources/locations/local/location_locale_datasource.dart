import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/data/mappers/model_to_companion_location_mapper.dart';
import 'package:niagara_app/features/location/data/models/location_model.dart';

abstract interface class ILocationsLocalDatasource {
  Future<Either<Failure, List<LocationModel>>> getLocations();

  Future<Either<Failure, void>> addLocation(LocationModel location);

  Future<Either<Failure, void>> updateLocation(LocationModel location);

  Future<Either<Failure, void>> deleteLocation(LocationModel location);

  Future<Either<Failure, LocationModel>> getPrimaryLocation();
}

@LazySingleton(as: ILocationsLocalDatasource)
class LocationsLocalDatasource implements ILocationsLocalDatasource {
  LocationsLocalDatasource({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  @override
  Future<Either<Failure, List<LocationModel>>> getLocations() => _execute(
        () => _database.allLocations.getLocations(),
      );

  @override
  Future<Either<Failure, void>> addLocation(LocationModel location) => _execute(
        () => _database.allLocations.insertLocation(location.toCompanion()),
      );

  @override
  Future<Either<Failure, void>> updateLocation(LocationModel location) =>
      _execute(
        () => _database.allLocations.updateLocation(location.toCompanion()),
      );

  @override
  Future<Either<Failure, void>> deleteLocation(LocationModel location) =>
      _execute(
        () => _database.allLocations.deleteLocation(location.toCompanion()),
      );

  @override
  Future<Either<Failure, LocationModel>> getPrimaryLocation() => _execute(
        () => _database.allLocations.getPrimaryLocation(),
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
