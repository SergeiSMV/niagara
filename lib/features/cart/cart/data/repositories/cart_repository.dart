import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';
import 'package:niagara_app/features/cart/cart/domain/repositories/cart_repository.dart';

class CartRepository extends BaseRepository implements ICartRepository {
  CartRepository(super.logger);

  @override
  Failure get failure => throw UnimplementedError();

  @override
  Future<Either<Failure, bool>> addProductToCart(Product product) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Cart>> getCartData() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Product>>> getCartRecommendations() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> removeAllFromCart() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> removeProductFromCart(Product product) {
    throw UnimplementedError();
  }
}
