import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';

abstract interface class INewProductsRepository {
  Future<Either<Failure, Products>> getNewProducts({required int page});
}
