import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';

abstract interface class ISpecialProductsRepository {
  Future<Either<Failure, Products>> getSpecialProducts({required int page});
}
