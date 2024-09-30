import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/cart/cart/domain/repositories/cart_repository.dart';

@injectable
class RemoveFromCartUseCase extends BaseUseCase<bool, RemoveFromCartParams> {
  RemoveFromCartUseCase(this._cartRepository);

  final ICartRepository _cartRepository;

  @override
  Future<Either<Failure, bool>> call(RemoveFromCartParams params) =>
      _cartRepository.removeProductFromCart(
        params.product,
        params.withdrawingWater,
        params.all,
      );
}

class RemoveFromCartParams extends Equatable {
  const RemoveFromCartParams({
    required this.product,
    this.withdrawingWater = false,
    this.all = false,
  });

  final Product product;

  final bool withdrawingWater;

  final bool all;

  @override
  List<Object> get props => [product, withdrawingWater];
}
