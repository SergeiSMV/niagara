import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/locations/shops/domain/models/shop.dart';

abstract interface class IShopsRepository {
  Future<Either<Failure, List<Shop>>> getShops();
}
