import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';
import 'package:niagara_app/features/cart/cart/domain/repositories/cart_repository.dart';

@injectable
class GetCartUseCase extends BaseUseCase<Cart, GetCartParams> {
  GetCartUseCase(this._cartRepository);

  final ICartRepository _cartRepository;

  @override
  Future<Either<Failure, Cart>> call(GetCartParams params) =>
      _cartRepository.getCartData(
        locationId: params.locationId,
        bonuses: params.bonuses,
        promocode: params.promocode,
        tareCount: params.tareCount,
        allTare: params.allTare,
      );
}

class GetCartParams extends Equatable {
  const GetCartParams({
    required this.locationId,
    required this.bonuses,
    required this.promocode,
    required this.tareCount,
    required this.allTare,
  });

  final String locationId;
  final int bonuses;
  final String promocode;
  final int tareCount;
  final bool allTare;

  @override
  List<Object> get props => [
        locationId,
        bonuses,
        promocode,
        tareCount,
        allTare,
      ];
}
