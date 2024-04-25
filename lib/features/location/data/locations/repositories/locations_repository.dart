import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/extensions/iterable_ext.dart';
import 'package:niagara_app/features/location/data/locations/local/data_source/location_locale_data_source.dart';
import 'package:niagara_app/features/location/data/locations/mappers/location_dto_mapper.dart';
import 'package:niagara_app/features/location/data/locations/mappers/location_entity_mapper.dart';
import 'package:niagara_app/features/location/data/locations/remote/data_source/locations_remote_data_source.dart';
import 'package:niagara_app/features/location/data/locations/remote/dto/location_dto.dart';
import 'package:niagara_app/features/location/domain/models/location.dart';
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
          final local = await _getLocalLocations();
          if (local.isNotEmpty) return local;

          final remote = await _getRemoteLocations();

          if (remote.isNotEmpty) {
            final entities = remote
                .mapIndexed((index, dto) => dto.toEntity(id: index + 1))
                .toList();
            await _localDatasource.saveLocations(entities);

            final saved = await _getLocalLocations();

            if (!saved.any((location) => location.isDefault)) {
              await _localDatasource.updateLocation(
                saved.first.toEntity(
                  isDefault: true,
                ),
              );
            }

            return _getLocalLocations();
          }

          return [];
        },
      );

  @override
  Future<Either<Failure, void>> addLocation(Location location) =>
      execute(() async {
        await _checkHasDefaultLocation(location);
        await _localDatasource.addLocation(location.toEntity());
      });

  @override
  Future<Either<Failure, void>> updateLocation(Location location) =>
      execute(() async {
        await _checkHasDefaultLocation(location);
        await _localDatasource.updateLocation(location.toEntity());
      });

  @override
  Future<Either<Failure, void>> deleteLocation(Location location) => execute(
        () => _localDatasource.deleteLocation(location.toEntity()),
      );

  Future<List<Location>> _getLocalLocations() async =>
      _localDatasource.getLocations().fold(
            (failure) => throw failure,
            (entities) => entities.map((entity) => entity.toModel()).toList(),
          );

  Future<List<LocationDto>> _getRemoteLocations() async =>
      _remoteDatasource.getLocations().fold(
            (failure) => throw failure,
            (locations) => locations,
          );

  Future<void> _checkHasDefaultLocation(Location location) async {
    if (location.isDefault) {
      final locations = await getLocations().fold(
        (failure) => throw failure,
        (locations) => locations,
      );

      for (final l in locations) {
        if (l.isDefault && l != location) {
          await _localDatasource.updateLocation(
            location.toEntity(isDefault: false),
          );
        }
      }
    }
  }
}
