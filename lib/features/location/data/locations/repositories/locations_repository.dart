import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/extensions/iterable_ext.dart';
import 'package:niagara_app/features/location/data/locations/local/data_source/location_locale_data_source.dart';
import 'package:niagara_app/features/location/data/locations/mappers/location_dto_mapper.dart';
import 'package:niagara_app/features/location/data/locations/mappers/location_entity_mapper.dart';
import 'package:niagara_app/features/location/data/locations/remote/data_source/locations_remote_data_source.dart';
import 'package:niagara_app/features/location/data/locations/remote/dto/location_dto.dart';
import 'package:niagara_app/features/location/domain/models/location.dart';
import 'package:niagara_app/features/location/domain/repositories/locations_repository.dart';
import 'package:niagara_app/features/profile/data/local/data_source/user_local_data_source.dart';

@LazySingleton(as: ILocationsRepository)
class LocationsRepository extends BaseRepository
    implements ILocationsRepository {
  LocationsRepository({
    required ILocationsLocalDatasource localDatasource,
    required ILocationsRemoteDatasource remoteDatasource,
    required IUserLocalDataSource userLocalDataSource,
    required super.logger,
  })  : _localDatasource = localDatasource,
        _remoteDatasource = remoteDatasource,
        _userLocalDataSource = userLocalDataSource;

  final ILocationsLocalDatasource _localDatasource;
  final ILocationsRemoteDatasource _remoteDatasource;
  final IUserLocalDataSource _userLocalDataSource;

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
        // Получить телефон пользователя из локального источника данных
        final phone = await _getUserPhone();
        if (phone == null) throw const LocationsRepositoryFailure();

        // Добавить местоположение в удаленный источник данных и локальную БД
        await _addLocation(location, phone);

        // Обновить дефолтное местоположение
        await _updateDefaultLocation(location);
      });

  @override
  Future<Either<Failure, void>> updateLocation(Location location) =>
      execute(() async => _updateLocation(location));

  @override
  Future<Either<Failure, void>> deleteLocation(Location location) =>
      execute(() async => _deleteLocation(location));

  @override
  Future<Either<Failure, void>> setDefaultLocation(Location location) =>
      execute(() async => _updateDefaultLocation(location));

  Future<String?> _getUserPhone() async => _userLocalDataSource.getUser().fold(
        (failure) => throw failure,
        (user) => user?.phone,
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

  Future<void> _addLocation(Location location, String phone) async =>
      _remoteDatasource
          .addLocation(location: location.toDto(), phone: phone)
          .fold(
            (failure) => throw failure,
            (locationId) async => _localDatasource.addLocation(
              location.toEntity(
                isDefault: true,
                locationId: locationId,
              ),
            ),
          );

  Future<void> _updateLocation(Location location) async =>
      _remoteDatasource.addLocation(location: location.toDto()).fold(
        (failure) => throw failure,
        (locationId) async {
          await _localDatasource.updateLocation(location.toEntity());
        },
      );

  Future<void> _deleteLocation(Location location) async =>
      _remoteDatasource.deleteLocation(location: location.toDto()).fold(
        (failure) => throw failure,
        (success) async {
          if (!success) throw const LocationsRepositoryFailure();
          await _localDatasource.deleteLocation(location.toEntity());
        },
      );

  Future<void> _updateDefaultLocation(Location location) async {
    final locations = await _getLocalLocations();
    for (final loc in locations) {
      if (loc.isDefault) {
        await _localDatasource.updateLocation(loc.toEntity(isDefault: false));
      }

      if (loc.id == location.id) {
        await _localDatasource.updateLocation(loc.toEntity(isDefault: true));
      }
    }
  }
}
