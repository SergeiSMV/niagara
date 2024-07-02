import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';
import 'package:niagara_app/features/cart/cart/domain/repositories/cart_repository.dart';

@injectable
class GetCartUseCase extends BaseUseCase<Cart, NoParams> {
  GetCartUseCase(this._cartRepository);

  final ICartRepository _cartRepository;

  @override
  Future<Either<Failure, Cart>> call([NoParams? params]) =>
      _cartRepository.getCartData();
}
