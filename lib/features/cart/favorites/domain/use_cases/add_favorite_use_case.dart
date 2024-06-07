import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/cart/favorites/domain/repositories/favorites_repository.dart';

@injectable
class AddFavoriteUseCase extends BaseUseCase<void, Product> {
  AddFavoriteUseCase(this._favoritesRepository);

  final IFavoritesRepository _favoritesRepository;

  @override
  Future<Either<Failure, void>> call(Product params) =>
      _favoritesRepository.addFavorite(params);
}
