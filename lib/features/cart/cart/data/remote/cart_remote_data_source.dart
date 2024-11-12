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

  Future<Either<Failure, CartDto>> addProductToCart({
    required String productId,
    required String locationId,
    required int bonuses,
    required String promocode,
    required int tareCount,
    required bool allTare,
    String? complectId,
  });

  Future<Either<Failure, CartDto>> removeProductFromCart({
    required String productId,
    required String locationId,
    required int bonuses,
    required String promocode,
    required int tareCount,
    required bool allTare,
    String? complectId,
    bool all = false,
  });

  Future<Either<Failure, CartDto>> clearCart({
    required CartClearTypes type,
    required String locationId,
    required int bonuses,
    required String promocode,
    required int tareCount,
    required bool allTare,
  });

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
        converter: CartDto.fromJson,
        failure: CartRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, CartDto>> addProductToCart({
    required String productId,
    required String locationId,
    required int bonuses,
    required String promocode,
    required int tareCount,
    required bool allTare,
    String? complectId,
  }) =>
      _requestHandler.sendRequest<CartDto, Map<String, dynamic>>(
        request: (dio) => dio.post(
          ApiConst.kAddProductToCart,
          data: {
            'product_id': productId,
            if (complectId != null) 'complect_id': complectId,
            'LOCATION': locationId,
            'BONUSES': bonuses,
            'PROMOCODE': promocode,
            'TARA_COUNT': tareCount,
            'TARA_ALL': allTare,
          },
        ),
        converter: CartDto.fromJson,
        failure: CartRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, CartDto>> removeProductFromCart({
    required String productId,
    required String locationId,
    required int bonuses,
    required String promocode,
    required int tareCount,
    required bool allTare,
    String? complectId,
    bool all = false,
  }) =>
      _requestHandler.sendRequest<CartDto, Map<String, dynamic>>(
        request: (dio) => dio.delete(
          all
              ? ApiConst.kRemoveWholeProductCount
              : ApiConst.kRemoveProductFromCart,
          data: {
            'product_id': productId,
            if (complectId != null) 'complect_id': complectId,
            'LOCATION': locationId,
            'BONUSES': bonuses,
            'PROMOCODE': promocode,
            'TARA_COUNT': tareCount,
            'TARA_ALL': allTare,
          },
        ),
        converter: CartDto.fromJson,
        failure: CartRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, CartDto>> clearCart({
    required CartClearTypes type,
    required String locationId,
    required int bonuses,
    required String promocode,
    required int tareCount,
    required bool allTare,
  }) =>
      _requestHandler.sendRequest<CartDto, Map<String, dynamic>>(
        request: (dio) => dio.delete(
          ApiConst.kClearCart,
          data: {
            'type': type.typeToString(),
            'LOCATION': locationId,
            'BONUSES': bonuses,
            'PROMOCODE': promocode,
            'TARA_COUNT': tareCount,
            'TARA_ALL': allTare,
          },
        ),
        converter: CartDto.fromJson,
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
