import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/cart/cart/domain/repositories/cart_repository.dart';

@injectable
class CheckPromoCodeUseCase extends BaseUseCase<bool, String> {
  CheckPromoCodeUseCase(this._cartRepository);

  final ICartRepository _cartRepository;

  @override
  Future<Either<Failure, bool>> call(String code) =>
      _cartRepository.checkPromoCode(code: code);
}
