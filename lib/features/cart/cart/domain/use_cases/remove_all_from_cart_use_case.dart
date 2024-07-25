import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/cart_clear_types.dart';
import 'package:niagara_app/features/cart/cart/domain/repositories/cart_repository.dart';

@injectable
class RemoveAllFromCartUseCase extends BaseUseCase<bool, CartClearTypes> {
  RemoveAllFromCartUseCase(this._cartRepository);

  final ICartRepository _cartRepository;

  @override
  Future<Either<Failure, bool>> call(CartClearTypes type) =>
      _cartRepository.removeAllFromCart(type: type);
}
