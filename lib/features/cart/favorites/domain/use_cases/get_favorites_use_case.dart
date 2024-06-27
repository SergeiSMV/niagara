import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/cart/favorites/domain/repositories/favorites_repository.dart';

@injectable
class GetFavoritesUseCase extends BaseUseCase<List<Product>, NoParams> {
  GetFavoritesUseCase(this._favoritesRepository);

  final IFavoritesRepository _favoritesRepository;

  @override
  Future<Either<Failure, List<Product>>> call([NoParams? params]) =>
      _favoritesRepository.getFavorites();
}
