import 'package:niagara_app/core/common/data/remote/dto/product_dto.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/cart_clear_types.dart';
import 'package:niagara_app/features/cart/cart/data/remote/cart_dto.dart';

abstract interface class ICartRemoteDataSource {
  Future<Either<Failure, CartDto>> getCart({
    required String locationId,
    required int bonuses,
    required String promocode,
    required int tareCount,
    required bool allTare,
  });

  Future<Either<Failure, bool>> addProductToCart(
    String productId, [
    String? complectId,
  ]);

  Future<Either<Failure, bool>> removeProductFromCart(
    String productId, [
    String? complectId,
  ]);

  Future<Either<Failure, bool>> clearCart({required CartClearTypes type});

  Future<Either<Failure, List<ProductDto>>> getRecommendedProducts();

  Future<Either<Failure, bool>> checkPromoCode({required String code});
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
        request: (dio) => dio.post(
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
  Future<Either<Failure, bool>> addProductToCart(
    String productId, [
    String? complectId,
  ]) =>
      _requestHandler.sendRequest<bool, Map<String, dynamic>>(
        request: (dio) => dio.post(
          ApiConst.kAddProductToCart,
          data: {
            'product_id': productId,
            if (complectId != null) 'complect_id': complectId,
          },
        ),
        converter: (json) => json['success'] as bool,
        failure: CartRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, bool>> removeProductFromCart(
    String productId, [
    String? complectId,
  ]) =>
      _requestHandler.sendRequest<bool, Map<String, dynamic>>(
        request: (dio) => dio.delete(
          ApiConst.kRemoveProductFromCart,
          data: {
            'product_id': productId,
            if (complectId != null) 'complect_id': complectId,
          },
        ),
        converter: (json) => json['success'] as bool,
        failure: CartRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, bool>> clearCart({required CartClearTypes type}) =>
      _requestHandler.sendRequest<bool, Map<String, dynamic>>(
        request: (dio) => dio.delete(
          ApiConst.kClearCart,
          data: {
            'type': type.typeToString(),
          },
        ),
        converter: (json) => json['success'] as bool,
        failure: CartRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, List<ProductDto>>> getRecommendedProducts() async =>
      _requestHandler.sendRequest<List<ProductDto>, List<dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetRecommendedProducts,
        ),
        converter: (json) => json
            .map((e) => ProductDto.fromJson(e as Map<String, dynamic>))
            .toList(),
        failure: CartRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, bool>> checkPromoCode({required String code}) =>
      _requestHandler.sendRequest<bool, Map<String, dynamic>>(
        request: (dio) => dio.post(
          ApiConst.kApplyPromoCode,
          data: {
            'PROMOCODE': code,
          },
        ),
        converter: (json) => json['valid'] as bool,
        failure: CartRemoteDataFailure.new,
      );
}
