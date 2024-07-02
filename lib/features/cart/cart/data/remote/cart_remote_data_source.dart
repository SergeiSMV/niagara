import 'package:niagara_app/core/common/data/remote/dto/product_dto.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/cart/cart/data/remote/cart_dto.dart';

abstract interface class ICartRemoteDataSource {
  Future<Either<Failure, CartDto>> getCart({
    required String locationId,
    required int bonuses,
    required String promocode,
    required int tareCount,
    required bool allTare,
  });

  Future<Either<Failure, bool>> addProductToCart(ProductDto product);

  Future<Either<Failure, bool>> removeProductFromCart(ProductDto product);

  Future<Either<Failure, bool>> clearCart();

  Future<Either<Failure, List<ProductDto>>> getRecommendedProducts();
}

@LazySingleton(as: ICartRemoteDataSource)
class CartRemoteDataSource implements ICartRemoteDataSource {
  CartRemoteDataSource(this._requestHandler);

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, CartDto>> getCart({
    required String locationId,
    required int bonuses,
    required String promocode,
    required int tareCount,
    required bool allTare,
  }) =>
      _requestHandler.sendRequest<CartDto, Map<String, dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetCart,
          data: {
            'LOCATION': locationId,
            'BONUSES': bonuses,
            'PROMOCODE': promocode,
            'TARA_COUNT': tareCount,
            'TARA_ALL': allTare,
          },
        ),
        converter: (json) => CartDto.fromJson(json),
        failure: CartRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, bool>> addProductToCart(ProductDto product) =>
      _requestHandler.sendRequest<bool, Map<String, dynamic>>(
        request: (dio) => dio.post(
          ApiConst.kAddProductToCart,
          data: product.toJson(),
        ),
        converter: (json) => json['success'] as bool,
        failure: CartRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, bool>> removeProductFromCart(ProductDto product) =>
      _requestHandler.sendRequest<bool, Map<String, dynamic>>(
        request: (dio) => dio.post(
          ApiConst.kRemoveProductFromCart,
          data: product.toJson(),
        ),
        converter: (json) => json['success'] as bool,
        failure: CartRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, bool>> clearCart() =>
      _requestHandler.sendRequest<bool, Map<String, dynamic>>(
        request: (dio) => dio.post(
          ApiConst.kClearCart,
        ),
        converter: (json) => json['success'] as bool,
        failure: CartRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, List<ProductDto>>> getRecommendedProducts() async =>
      _requestHandler.sendRequest<List<ProductDto>, Map<String, dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetRecommendedProducts,
        ),
        converter: (json) {
          final products = (json as List<dynamic>)
              .map((e) => ProductDto.fromJson(e as Map<String, dynamic>))
              .toList();

          return products;
        },
        failure: CartRemoteDataFailure.new,
      );
}
