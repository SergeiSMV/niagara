import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/domain/models/shop.dart';

abstract interface class IShopsRepository {
  /// Получает список магазинов из сети.
  Future<Either<Failure, List<Shop>>> getShops();

  /// Получает магазин по id.
  Future<Either<Failure, Shop>> getShopById({required int id});
}
