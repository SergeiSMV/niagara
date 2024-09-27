import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/cart/cart/domain/repositories/cart_repository.dart';

@injectable
class AddToCartUseCase extends BaseUseCase<bool, AddToCartParams> {
  AddToCartUseCase(this._cartRepository);

  final ICartRepository _cartRepository;

  @override
  Future<Either<Failure, bool>> call(AddToCartParams params) =>
      _cartRepository.addProductToCart(params.product, params.withdrawingWater);
}

class AddToCartParams extends Equatable {
  const AddToCartParams({required this.product, this.withdrawingWater = false});

  final Product product;

  final bool withdrawingWater;

  @override
  List<Object> get props => [product, withdrawingWater];
}
