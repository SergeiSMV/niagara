import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/locations/cities/data/local/data_source/cities_local_data_source.dart';
import 'package:niagara_app/features/locations/shops/data/local/data_source/shops_local_data_source.dart';
import 'package:niagara_app/features/locations/shops/data/mappers/shop_dto_mapper.dart';
import 'package:niagara_app/features/locations/shops/data/mappers/shop_entity_mapper.dart';
import 'package:niagara_app/features/locations/shops/data/remote/data_source/shops_remote_data_source.dart';
import 'package:niagara_app/features/locations/shops/data/remote/dto/shop_dto.dart';
import 'package:niagara_app/features/locations/shops/domain/models/shop.dart';
import 'package:niagara_app/features/locations/shops/domain/repositories/shops_repository.dart';

@LazySingleton(as: IShopsRepository)
class ShopsRepository extends BaseRepository implements IShopsRepository {
  ShopsRepository(
    super._logger,
    this._shopsLDS,
    this._shopsRDS,
    this._cityLDS,
  );

  final IShopsLocalDataSource _shopsLDS;
  final IShopsRemoteDataSource _shopsRDS;
  final ICitiesLocalDataSource _cityLDS;

  @override
  Failure get failure => const ShopsRepositoryFailure();

  @override
  Future<Either<Failure, List<Shop>>> getShops() => execute(() async {
        final localShops = await _getLocalShops();
        if (localShops.isNotEmpty) return localShops;

        final remoteShops = await _getRemoteShops();
        if (remoteShops.isNotEmpty) {
          final entities = remoteShops.map((dto) => dto.toEntity()).toList();
          await _shopsLDS.setShops(entities);

          return _getLocalShops();
        }
        return [];
      });

  Future<List<Shop>> _getLocalShops() async => _shopsLDS.getShops().fold(
        (failure) => throw failure,
        (entities) => entities.map((entity) => entity.toModel()).toList(),
      );

  Future<List<ShopDto>> _getRemoteShops() async {
    final city = await _cityLDS
        .getCity()
        .fold((failure) => throw failure, (city) => city.locality);

    return _shopsRDS.getShops(city: city).fold(
          (failure) => throw failure,
          (dtos) => dtos,
        );
  }
}
