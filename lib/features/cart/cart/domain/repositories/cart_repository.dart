import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';

abstract interface class ICartRepository {
  Future<Either<Failure, Cart>> getCartData({
    required String locationId,
    required int bonuses,
    required String promocode,
    required int tareCount,
    required bool allTare,
  });

  Future<Either<Failure, bool>> addProductToCart(Product product);

  Future<Either<Failure, bool>> removeProductFromCart(Product product);

  Future<Either<Failure, bool>> removeAllFromCart();

  Future<Either<Failure, List<Product>>> getCartRecommendations();
}
