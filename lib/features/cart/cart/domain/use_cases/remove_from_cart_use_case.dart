import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';
import 'package:niagara_app/features/cart/cart/domain/repositories/cart_repository.dart';
import 'package:niagara_app/features/cart/cart/domain/use_cases/cart_params.dart';

@injectable
class RemoveFromCartUseCase extends BaseUseCase<Cart, RemoveFromCartParams> {
  RemoveFromCartUseCase(this._cartRepository);

  final ICartRepository _cartRepository;

  @override
  Future<Either<Failure, Cart>> call(RemoveFromCartParams params) =>
      _cartRepository.removeProductFromCart(
        product: params.product,
        withdrawingWater: params.withdrawingWater,
        allTare: params.cartParams.allTare,
        bonuses: params.cartParams.bonuses,
        locationId: params.cartParams.locationId,
        promocode: params.cartParams.promocode,
        tareCount: params.cartParams.tareCount,
        otherTareCount: params.cartParams.otherTareCount,
        all: params.all,
      );
}

class RemoveFromCartParams extends Equatable {
  const RemoveFromCartParams({
    required this.product,
    required this.cartParams,
    this.withdrawingWater = false,
    this.all = false,
  });

  final Product product;

  final bool withdrawingWater;

  final bool all;

  final CartParams cartParams;

  @override
  List<Object> get props => [product, withdrawingWater];
}
