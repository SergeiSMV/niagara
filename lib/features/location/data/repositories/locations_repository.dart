import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/data/datasources/locations/local/location_locale_datasource.dart';
import 'package:niagara_app/features/location/data/datasources/locations/remote/locations_remote_datasource.dart';
import 'package:niagara_app/features/location/data/mappers/location_mapper.dart';
import 'package:niagara_app/features/location/domain/entities/locality.dart';
import 'package:niagara_app/features/location/domain/repositories/locations_repository.dart';

@LazySingleton(as: ILocationsRepository)
class LocationsRepository extends BaseRepository
    implements ILocationsRepository {
  LocationsRepository({
    required ILocationsLocalDatasource localDatasource,
    required ILocationsRemoteDatasource remoteDatasource,
    required super.logger,
  })  : _localDatasource = localDatasource,
        _remoteDatasource = remoteDatasource;

  final ILocationsLocalDatasource _localDatasource;
  final ILocationsRemoteDatasource _remoteDatasource;

  @override
  Failure get failure => const LocationsRepositoryFailure();

  @override
  Future<Either<Failure, List<Location>>> getLocations() => execute(
        () async {
          final local = await _localDatasource.getLocations().fold(
                (failure) => throw failure,
                (locations) => locations.map((e) => e.toLocation()).toList(),
              );
          if (local.isNotEmpty) return local;

          final remote = await _remoteDatasource.getLocations().fold(
                (failure) => throw failure,
                (locations) => locations,
              );

          if (remote.isNotEmpty) {
            await _localDatasource.saveLocations(remote);

            return _localDatasource.getLocations().fold(
                  (failure) => throw failure,
                  (locations) => locations.map((e) => e.toLocation()).toList(),
                );
          }

          return [];
        },
      );

  @override
  Future<Either<Failure, void>> addLocation(Location location) =>
      execute(() async {
        await _checkHasPrimaryLocation(location);
        await _localDatasource.addLocation(location.toModel());
      });

  @override
  Future<Either<Failure, void>> updateLocation(Location location) =>
      execute(() async {
        await _checkHasPrimaryLocation(location);
        await _localDatasource.updateLocation(location.toModel());
      });

  @override
  Future<Either<Failure, void>> deleteLocation(Location location) => execute(
        () => _localDatasource.deleteLocation(location.toModel()),
      );

  Future<void> _checkHasPrimaryLocation(Location location) async {
    if (location.isPrimary) {
      final locations = await getLocations().fold(
        (failure) => throw failure,
        (locations) => locations,
      );

      for (final loc in locations) {
        if (loc.isPrimary && loc != location) {
          await _localDatasource.updateLocation(
            location.toModel(isPrimary: false),
          );
        }
      }
    }
  }
}
