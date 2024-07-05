import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/cart/cart/domain/repositories/cart_repository.dart';

@injectable
class GetRecommendsCartUseCase extends BaseUseCase<List<Product>, NoParams> {
  GetRecommendsCartUseCase(this._cartRepository);

  final ICartRepository _cartRepository;

  @override
  Future<Either<Failure, List<Product>>> call([NoParams? params]) =>
      _cartRepository.getCartRecommendations();
}
