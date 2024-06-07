import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';

abstract interface class IFavoritesRepository {
  Future<Either<Failure, List<Product>>> getFavorites();

  Future<Either<Failure, void>> addFavorite(Product product);

  Future<Either<Failure, void>> removeFavorite(Product product);

  Future<Either<Failure, void>> removeAllFavorites();
}
