import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/data/datasources/locations/local/location_locale_datasource.dart';
import 'package:niagara_app/features/location/data/mappers/location_mapper.dart';
import 'package:niagara_app/features/location/domain/entities/locality.dart';
import 'package:niagara_app/features/location/domain/repositories/locations_repository.dart';

@LazySingleton(as: ILocationsRepository)
class LocationsRepository extends BaseRepository
    implements ILocationsRepository {
  LocationsRepository({
    required ILocationsLocalDatasource localDatasource,
    required super.logger,
  }) : _localDatasource = localDatasource;

  final ILocationsLocalDatasource _localDatasource;

  @override
  Future<Either<Failure, List<Location>>> getLocations() => execute(
        () => _localDatasource.getLocations().fold(
              (failure) => throw const LocationsDataFailure(),
              (locations) => locations.map((e) => e.toLocation()).toList(),
            ),
        const LocationsDataFailure(),
      );

  @override
  Future<Either<Failure, Location>> getPrimaryLocation() => execute(
        () => _localDatasource.getPrimaryLocation().fold(
              (failure) => throw LocationsDataFailure(failure.error),
              (location) => location.toLocation(),
            ),
        const LocationsDataFailure(),
      );

  @override
  Future<Either<Failure, void>> addLocation(Location location) => execute(
        () => _localDatasource.addLocation(location.toModel()),
        const LocationsDataFailure(),
      );

  @override
  Future<Either<Failure, void>> deleteLocation(Location location) => execute(
        () => _localDatasource.deleteLocation(location.toModel()),
        const LocationsDataFailure(),
      );

  @override
  Future<Either<Failure, void>> updateLocation(Location location) => execute(
        () => _localDatasource.updateLocation(location.toModel()),
        const LocationsDataFailure(),
      );
}
