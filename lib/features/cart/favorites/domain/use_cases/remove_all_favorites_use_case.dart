import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/cart/favorites/domain/repositories/favorites_repository.dart';

@injectable
class RemoveAllFavoritesUseCase extends BaseUseCase<void, NoParams> {
  RemoveAllFavoritesUseCase(this._favoritesRepository);

  final IFavoritesRepository _favoritesRepository;

  @override
  Future<Either<Failure, void>> call([NoParams? params]) =>
      _favoritesRepository.removeAllFavorites();
}
