import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/cart/cart/domain/repositories/cart_repository.dart';

@injectable
class ApplyPromoCodeUseCase extends BaseUseCase<bool, String> {
  ApplyPromoCodeUseCase(this._cartRepository);

  final ICartRepository _cartRepository;

  @override
  Future<Either<Failure, bool>> call(String code) =>
      _cartRepository.applyPromoCode(code: code);
}
