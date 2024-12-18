import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/cart_clear_types.dart';
import 'package:niagara_app/features/cart/cart/data/mappers/cart_mapper.dart';
import 'package:niagara_app/features/cart/cart/data/remote/cart_remote_data_source.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';
import 'package:niagara_app/features/cart/cart/domain/repositories/cart_repository.dart';

@LazySingleton(as: ICartRepository)
class CartRepository extends BaseRepository implements ICartRepository {
  CartRepository(super.logger, super._networkInfo, this._cartRDS);

  final ICartRemoteDataSource _cartRDS;

  @override
  Failure get failure => const CartRepositoryFailure();

  @override
  Future<Either<Failure, Cart>> getCartData({
    required String locationId,
    required int bonuses,
    required String promocode,
    required int tareCount,
    required bool allTare,
  }) =>
      execute(
        () => _cartRDS
            .getCart(
              locationId: locationId,
              bonuses: bonuses,
              promocode: promocode,
              tareCount: tareCount,
              allTare: allTare,
            )
            .fold(
              (failure) => throw failure,
              (remoteCart) => remoteCart.toModel(),
            ),
      );

  @override
  Future<Either<Failure, Cart>> addProductToCart({
    required Product product,
    required bool withdrawingWater,
    required String locationId,
    required int bonuses,
    required String promocode,
    required int tareCount,
    required bool allTare,
  }) =>
      execute(
        () => _cartRDS
            .addProductToCart(
              productId: product.id,
              complectId: withdrawingWater ? product.complectId : null,
              locationId: locationId,
              bonuses: bonuses,
              promocode: promocode,
              tareCount: tareCount,
              allTare: allTare,
            )
            .fold(
              (failure) => throw failure,
              (dto) => dto.toModel(),
            ),
      );

  @override
  Future<Either<Failure, Cart>> removeProductFromCart({
    required Product product,
    required bool withdrawingWater,
    required bool all,
    required String locationId,
    required int bonuses,
    required String promocode,
    required int tareCount,
    required bool allTare,
  }) =>
      execute(
        () => _cartRDS
            .removeProductFromCart(
              productId: product.id,
              complectId: withdrawingWater ? product.complectId : null,
              locationId: locationId,
              bonuses: bonuses,
              promocode: promocode,
              tareCount: tareCount,
              allTare: allTare,
              all: all,
            )
            .fold(
              (failure) => throw failure,
              (dto) => dto.toModel(),
            ),
      );

  @override
  Future<Either<Failure, Cart>> removeAllFromCart({
    required CartClearTypes type,
    required String locationId,
    required int bonuses,
    required String promocode,
    required int tareCount,
    required bool allTare,
  }) =>
      execute(
        () => _cartRDS
            .clearCart(
              type: type,
              locationId: locationId,
              bonuses: bonuses,
              promocode: promocode,
              tareCount: tareCount,
              allTare: allTare,
            )
            .fold(
              (failure) => throw failure,
              (dto) => dto.toModel(),
            ),
      );

  @override
  Future<Either<Failure, bool>> checkPromoCode({required String code}) =>
      execute(
        () => _cartRDS.checkPromoCode(code: code).fold(
              (failure) => throw failure,
              (success) => success,
            ),
      );
}
