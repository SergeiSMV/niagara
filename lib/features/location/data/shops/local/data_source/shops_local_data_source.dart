import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/data/shops/local/entities/shop_entity.dart';
import 'package:niagara_app/features/location/data/shops/mappers/shop_entity_mapper.dart';

abstract interface class IShopsLocalDataSource {
  Future<Either<Failure, List<ShopEntity>>> getShops();

  Future<Either<Failure, void>> setShops(List<ShopEntity> shops);
}

@LazySingleton(as: IShopsLocalDataSource)
class ShopsLocalDataSource implements IShopsLocalDataSource {
  ShopsLocalDataSource({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  @override
  Future<Either<Failure, List<ShopEntity>>> getShops() => _execute(
        () async {
          final shops = await _database.allShops.getShops();
          return shops.map((e) => e.toEntity()).toList();
        },
      );

  @override
  Future<Either<Failure, void>> setShops(List<ShopEntity> shops) => _execute(
        () async {
          await _database.allShops.clearShops();
          await _database.allShops
              .insertShops(shops.map((e) => e.toCompanion()).toList());
        },
      );

  Future<Either<Failure, T>> _execute<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return Right(result);
    } catch (e) {
      return Left(ShopsLocalDataFailure(e.toString()));
    }
  }
}
