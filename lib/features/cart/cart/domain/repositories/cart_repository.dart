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
    required int otherTareCount,
    required bool allTare,
  });

  Future<Either<Failure, Cart>> addProductToCart({
    required Product product,
    required bool withdrawingWater,
    required String locationId,
    required int bonuses,
    required String promocode,
    required int tareCount,
    required int otherTareCount,
    required bool allTare,
  });

  Future<Either<Failure, Cart>> removeProductFromCart({
    required Product product,
    required bool withdrawingWater,
    required bool all,
    required String locationId,
    required int bonuses,
    required String promocode,
    required int tareCount,
    required int otherTareCount,
    required bool allTare,
  });

  Future<Either<Failure, Cart>> removeAllFromCart({
    required CartClearTypes type,
    required String locationId,
    required int bonuses,
    required String promocode,
    required int tareCount,
    required int otherTareCount,
    required bool allTare,
  });

  Future<Either<Failure, bool>> checkPromoCode({required String code});
}
