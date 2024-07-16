part of 'new_products_bloc.dart';

@freezed
class NewProductsState with _$NewProductsState {
  const factory NewProductsState.loading() = _LoadingNewProducts;

  const factory NewProductsState.loaded({
    required List<Product> products,
    required int totalItems,
  }) = _LoadedNewProducts;

  const factory NewProductsState.error() = _ErrorNewProducts;
}
