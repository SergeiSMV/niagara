part of 'cart_bloc.dart';

@freezed
class CartState with _$CartState {
  const factory CartState.empty() = _Empty;

  const factory CartState.loading({
    Cart? cart,
    List<Product>? recommends,
    required Set<String> pendingProducts,
  }) = _Loading;

  const factory CartState.loaded({
    required Cart cart,
    required List<Product> recommends,
  }) = _Loaded;

  const factory CartState.unauthorized() = _Unauthorized;

  const factory CartState.error() = _Error;
}
