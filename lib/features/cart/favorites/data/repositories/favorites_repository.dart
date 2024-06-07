import 'package:niagara_app/core/common/data/mappers/product_mapper.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/cart/favorites/data/local/data_source/favorites_local_data_source.dart';
import 'package:niagara_app/features/cart/favorites/domain/repositories/favorites_repository.dart';

@LazySingleton(as: IFavoritesRepository)
class FavoritesRepository extends BaseRepository
    implements IFavoritesRepository {
  FavoritesRepository(
    super.logger,
    this._favoriteLDS,
  );

  final IFavoritesLocalDataSource _favoriteLDS;

  @override
  Failure get failure => const FavoritesRepositoryFailure();

  @override
  Future<Either<Failure, List<Product>>> getFavorites() => execute(
        () => _favoriteLDS.getFavorites().fold(
              (failure) => throw failure,
              (entities) => entities
                  .map(
                    (entity) => entity.toModel(),
                  )
                  .toSet()
                  .toList(),
            ),
      );

  @override
  Future<Either<Failure, void>> addFavorite(Product product) =>
      execute(() => _favoriteLDS.addFavorite(product.toEntity()));

  @override
  Future<Either<Failure, void>> removeAllFavorites() =>
      execute(() => _favoriteLDS.clearFavorites());

  @override
  Future<Either<Failure, void>> removeFavorite(Product product) => execute(
        () => _favoriteLDS.deleteFavorite(product.toEntity()),
      );
}
