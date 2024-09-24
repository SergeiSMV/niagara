import 'package:niagara_app/core/common/data/remote/dto/pagination_dto.dart';
import 'package:niagara_app/core/common/data/remote/dto/product_dto.dart';
import 'package:niagara_app/core/core.dart';

abstract interface class IFavoritesRemoteDataSource {
  Future<Either<Failure, ProductsDto>> getFavorites({
    required int page,
  });

  Future<Either<Failure, bool>> addFavorite({
    required String login,
    required String productId,
  });

  Future<Either<Failure, bool>> removeFavorite({
    required String login,
    required String productId,
  });

  Future<Either<Failure, bool>> clearFavorite({
    required String login,
  });
}

@LazySingleton(as: IFavoritesRemoteDataSource)
class FavoritesRemoteDataSource implements IFavoritesRemoteDataSource {
  FavoritesRemoteDataSource(this._requestHandler);

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, ProductsDto>> getFavorites({
    required int page,
  }) =>
      _requestHandler.sendRequest<ProductsDto, Map<String, dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetFavorites,
          queryParameters: {
            'page': page,
          },
        ),
        converter: (json) {
          final products = (json['data'] as List<dynamic>)
              .map((e) => ProductDto.fromJson(e as Map<String, dynamic>))
              .toList();

          final pagination = PaginationDto.fromJson(
            json['pagination'] as Map<String, dynamic>,
          );

          return (products: products, pagination: pagination);
        },
        failure: FavoritesRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, bool>> addFavorite({
    required String login,
    required String productId,
  }) =>
      _requestHandler.sendRequest<bool, Map<String, dynamic>>(
        request: (dio) => dio.post(
          ApiConst.kAddFavorite,
          data: {
            'login': login,
            'product_id': productId,
          },
        ),
        converter: (json) => json['success'] as bool,
        failure: FavoritesRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, bool>> removeFavorite({
    required String login,
    required String productId,
  }) =>
      _requestHandler.sendRequest<bool, Map<String, dynamic>>(
        request: (dio) => dio.delete(
          ApiConst.kRemoveFavorite,
          data: {
            'login': login,
            'product_id': productId,
          },
        ),
        converter: (json) => json['success'] as bool,
        failure: FavoritesRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, bool>> clearFavorite({
    required String login,
  }) =>
      _requestHandler.sendRequest<bool, Map<String, dynamic>>(
        request: (dio) => dio.post(
          ApiConst.kClearFavorite,
          data: {
            'login': login,
          },
        ),
        converter: (json) => json['success'] as bool,
        failure: FavoritesRemoteDataFailure.new,
      );
}
