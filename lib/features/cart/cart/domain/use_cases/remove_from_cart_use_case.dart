import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/cart/cart/domain/repositories/cart_repository.dart';

@injectable
class RemoveFromCartUseCase extends BaseUseCase<bool, Product> {
  RemoveFromCartUseCase(this._cartRepository);

  final ICartRepository _cartRepository;

  @override
  Future<Either<Failure, bool>> call(Product params) =>
      _cartRepository.removeProductFromCart(params);
}
