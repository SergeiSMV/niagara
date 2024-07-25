import 'package:niagara_app/core/common/data/mappers/product_mapper.dart';
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
  Future<Either<Failure, bool>> addProductToCart(Product product) => execute(
        () => _cartRDS.addProductToCart(product.id).fold(
              (failure) => throw failure,
              (success) => success,
            ),
      );

  @override
  Future<Either<Failure, bool>> removeProductFromCart(Product product) =>
      execute(
        () => _cartRDS.removeProductFromCart(product.id).fold(
              (failure) => throw failure,
              (success) => success,
            ),
      );

  @override
  Future<Either<Failure, bool>> removeAllFromCart(
          {required CartClearTypes type}) =>
      execute(
        () => _cartRDS.clearCart(type: type).fold(
              (failure) => throw failure,
              (success) => success,
            ),
      );

  @override
  Future<Either<Failure, List<Product>>> getCartRecommendations() => execute(
        () => _cartRDS.getRecommendedProducts().fold(
              (failure) => throw failure,
              (products) => products.map((e) => e.toModel()).toList(),
            ),
      );
}
