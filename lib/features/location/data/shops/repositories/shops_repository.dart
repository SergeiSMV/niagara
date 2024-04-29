import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/data/cities/local/data_source/cities_local_data_source.dart';
import 'package:niagara_app/features/location/data/shops/local/data_source/shops_local_data_source.dart';
import 'package:niagara_app/features/location/data/shops/mappers/shop_dto_mapper.dart';
import 'package:niagara_app/features/location/data/shops/mappers/shop_entity_mapper.dart';
import 'package:niagara_app/features/location/data/shops/remote/data_source/shops_remote_data_source.dart';
import 'package:niagara_app/features/location/data/shops/remote/dto/shop_dto.dart';
import 'package:niagara_app/features/location/domain/models/shop.dart';
import 'package:niagara_app/features/location/domain/repositories/shops_repository.dart';

class ShopsRepository extends BaseRepository implements IShopsRepository {
  ShopsRepository({
    required IShopsLocalDataSource localDataSource,
    required IShopsRemoteDatasource remoteDatasource,
    required ICitiesLocalDatasource cityLocalDataSource,
    required super.logger,
  })  : _localDataSource = localDataSource,
        _remoteDatasource = remoteDatasource,
        _cityLocalDataSource = cityLocalDataSource;

  final IShopsLocalDataSource _localDataSource;
  final IShopsRemoteDatasource _remoteDatasource;
  final ICitiesLocalDatasource _cityLocalDataSource;

  @override
  Failure get failure => const ShopsRepositoryFailure();

  @override
  Future<Either<Failure, List<Shop>>> getShops() => execute(() async {
        final localShops = await _getLocalShops();
        if (localShops.isNotEmpty) return localShops;

        final remoteShops = await _getRemoteShops();
        if (remoteShops.isNotEmpty) {
          final entities = remoteShops.map((dto) => dto.toEntity()).toList();
          await _localDataSource.setShops(entities);

          return _getLocalShops();
        }
        return [];
      });

  Future<List<Shop>> _getLocalShops() async => _localDataSource.getShops().fold(
        (failure) => throw failure,
        (entities) => entities.map((entity) => entity.toModel()).toList(),
      );

  Future<List<ShopDto>> _getRemoteShops() async {
    final city = await _cityLocalDataSource
        .getCity()
        .fold((failure) => throw failure, (city) => city.locality);

    return _remoteDatasource.getShops(city: city).fold(
          (failure) => throw failure,
          (dtos) => dtos.map((dto) => dto).toList(),
        );
  }
}
