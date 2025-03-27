import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/cart_clear_types.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';
import 'package:niagara_app/features/cart/cart/domain/repositories/cart_repository.dart';
import 'package:niagara_app/features/cart/cart/domain/use_cases/cart_params.dart';

@injectable
class RemoveAllFromCartUseCase
    extends BaseUseCase<Cart, RemoveAllFromCartParams> {
  RemoveAllFromCartUseCase(this._cartRepository);

  final ICartRepository _cartRepository;

  @override
  Future<Either<Failure, Cart>> call(RemoveAllFromCartParams params) =>
      _cartRepository.removeAllFromCart(
        type: params.type,
        allTare: params.cartParams.allTare,
        bonuses: params.cartParams.bonuses,
        locationId: params.cartParams.locationId,
        promocode: params.cartParams.promocode,
        tareCount: params.cartParams.tareCount,
        otherTareCount: params.cartParams.otherTareCount,
      );
}

class RemoveAllFromCartParams extends Equatable {
  const RemoveAllFromCartParams({
    required this.type,
    required this.cartParams,
  });

  final CartClearTypes type;
  final CartParams cartParams;

  @override
  List<Object> get props => [type, cartParams];
}
