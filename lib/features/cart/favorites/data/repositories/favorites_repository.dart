import 'package:niagara_app/core/common/data/mappers/product_mapper.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/auth_status.dart';
import 'package:niagara_app/features/authorization/phone_auth/data/data_sources/auth_local_data_source.dart';
import 'package:niagara_app/features/cart/favorites/data/local/data_source/favorites_local_data_source.dart';
import 'package:niagara_app/features/cart/favorites/data/remote/data_source/favorites_remote_data_source.dart';
import 'package:niagara_app/features/cart/favorites/domain/repositories/favorites_repository.dart';
import 'package:niagara_app/features/profile/user/data/local/data_source/user_local_data_source.dart';

@LazySingleton(as: IFavoritesRepository)
class FavoritesRepository extends BaseRepository
    implements IFavoritesRepository {
  FavoritesRepository(
    super.logger,
    super._networkInfo,
    this._favoriteLDS,
    this._favoriteRDS,
    this._authLDS,
    this._userLDS,
  );

  final IFavoritesLocalDataSource _favoriteLDS;
  final IFavoritesRemoteDataSource _favoriteRDS;
  final IAuthLocalDataSource _authLDS;
  final IUserLocalDataSource _userLDS;

  int _currentPage = 0;
  int _totalPages = 0;

  @override
  Failure get failure => const FavoritesRepositoryFailure();

  @override
  Future<Either<Failure, List<Product>>> getFavorites() => execute(() async {
        final localFavorites = await _getLocalFavorites();

        if (localFavorites.isEmpty) {
          final hasAuth = await _hasAuth();
          if (!hasAuth) return [];

          final remoteFavorites = await _getAllRemoteFavorites().fold(
            (failure) => throw failure,
            (remoteFavorites) => remoteFavorites,
          );

          if (remoteFavorites.isNotEmpty) {
            await _favoriteLDS.clearFavorites();
            await _favoriteLDS.addAllFavorites(
              remoteFavorites.map((product) => product.toEntity()).toList(),
            );
            final localFavorites = await _getLocalFavorites();
            if (localFavorites.isNotEmpty) return localFavorites;
          }
        }
        return localFavorites;
      });

  @override
  Future<Either<Failure, void>> addFavorite(Product product) =>
      execute(() async {
        final hasAuth = await _hasAuth();

        if (!hasAuth) {
          await _favoriteLDS.addFavorite(product.toEntity());
        } else {
          final login = await _getUserPhone();
          await _favoriteRDS
              .addFavorite(
                login: login,
                productId: product.id,
              )
              .fold(
                (failure) => throw failure,
                (isAdded) => isAdded
                    ? _favoriteLDS.addFavorite(product.toEntity())
                    : throw failure,
              );
        }
      });

  @override
  Future<Either<Failure, void>> removeFavorite(Product product) =>
      execute(() async {
        final hasAuth = await _hasAuth();

        if (!hasAuth) {
          await _favoriteLDS.deleteFavorite(product.toEntity());
        } else {
          final login = await _getUserPhone();
          await _favoriteRDS
              .removeFavorite(
                login: login,
                productId: product.id,
              )
              .fold(
                (failure) => throw failure,
                (isRemoved) => isRemoved
                    ? _favoriteLDS.deleteFavorite(product.toEntity())
                    : throw failure,
              );
        }
      });

  @override
  Future<Either<Failure, void>> removeAllFavorites() => execute(() async {
        final hasAuth = await _hasAuth();
        if (!hasAuth) {
          await _favoriteLDS.clearFavorites();
        } else {
          await _favoriteRDS.clearFavorite().fold(
                (failure) => throw failure,
                (isCleared) =>
                    isCleared ? _favoriteLDS.clearFavorites() : throw failure,
              );
        }
      });

  Future<String> _getUserPhone() async => _userLDS.getUser().fold(
        (failure) => throw failure,
        (user) => user != null ? user.phone : throw failure,
      );

  Future<bool> _hasAuth() async => await _authLDS
      .checkAuthStatus()
      .then((value) => AuthenticatedStatus.values[value].hasAuth);

  Future<List<Product>> _getLocalFavorites() async =>
      await _favoriteLDS.getFavorites().fold(
            (failure) => throw failure,
            (entities) => entities
                .map(
                  (entity) => entity.toModel(),
                )
                .toSet()
                .toList(),
          );

  Future<Either<Failure, List<Product>>> _getAllRemoteFavorites() async {
    try {
      final List<Product> allFavorites = [];
      _currentPage = 1;
      _totalPages = 0;

      do {
        final response = await _favoriteRDS.getFavorites(
          page: _currentPage,
        );
        response.fold(
          (failure) => throw failure,
          (dto) {
            _currentPage = dto.pagination.current + 1;
            _totalPages = dto.pagination.total;
            allFavorites.addAll(
              dto.products.map((product) => product.toModel()).toSet().toList(),
            );
          },
        );
      } while (_currentPage <= _totalPages);

      return Right(allFavorites);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
