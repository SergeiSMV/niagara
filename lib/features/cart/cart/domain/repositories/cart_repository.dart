import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/cart_clear_types.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';

abstract interface class ICartRepository {
  Future<Either<Failure, Cart>> getCartData({
    required String locationId,
    required int bonuses,
    required String promocode,
    required int tareCount,
    required bool allTare,
  });

  Future<Either<Failure, bool>> addProductToCart(
    Product product,
    bool withdrawingWater,
  );

  Future<Either<Failure, bool>> removeProductFromCart(
    Product product,
    bool withdrawingWater,
  );

  Future<Either<Failure, bool>> removeAllFromCart({
    required CartClearTypes type,
  });

  Future<Either<Failure, List<Product>>> getCartRecommendations();

  Future<Either<Failure, bool>> checkPromoCode({required String code});
}
