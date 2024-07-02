import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/cart/cart/domain/repositories/cart_repository.dart';

@injectable
class RemoveFromCartUseCase extends BaseUseCase<bool, NoParams> {
  RemoveFromCartUseCase(this._cartRepository);

  final ICartRepository _cartRepository;

  @override
  Future<Either<Failure, bool>> call([NoParams? params]) =>
      _cartRepository.removeAllFromCart();
}
