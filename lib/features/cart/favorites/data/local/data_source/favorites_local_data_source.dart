import 'package:niagara_app/core/common/data/local/entities/product_entity.dart';
import 'package:niagara_app/core/common/data/mappers/product_mapper.dart';
import 'package:niagara_app/core/core.dart';

abstract interface class IFavoritesLocalDataSource {
  Future<Either<Failure, List<ProductEntity>>> getFavorites();

  Future<Either<Failure, void>> addFavorite(ProductEntity favorite);

  Future<Either<Failure, void>> deleteFavorite(ProductEntity favorite);

  Future<Either<Failure, void>> clearFavorites();
}

@LazySingleton(as: IFavoritesLocalDataSource)
class FavoritesLocalDataSource implements IFavoritesLocalDataSource {
  FavoritesLocalDataSource(this._database);

  final AppDatabase _database;

  @override
  Future<Either<Failure, List<ProductEntity>>> getFavorites() => _execute(
        () async => (await _database.allFavorites.getFavorites())
            .map((table) => table.toEntity())
            .toList(),
      );

  @override
  Future<Either<Failure, void>> addFavorite(ProductEntity favorite) => _execute(
        () => _database.allFavorites.insertFavorite(favorite.toCompanion()),
      );

  @override
  Future<Either<Failure, void>> deleteFavorite(ProductEntity favorite) =>
      _execute(
        () => _database.allFavorites.deleteFavorite(favorite.toCompanion()),
      );

  @override
  Future<Either<Failure, void>> clearFavorites() => _execute(
        () => _database.allFavorites.deleteAllFavorites(),
      );

  Future<Either<Failure, T>> _execute<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
