part of 'special_products_bloc.dart';

@freezed
class SpecialProductsState with _$SpecialProductsState {
  const factory SpecialProductsState.loading() = _LoadingSpecialProducts;

  const factory SpecialProductsState.loaded({
    required List<Product> products,
    required int totalItems,
    required bool loadingMore,
  }) = _LoadedSpecialProducts;

  const factory SpecialProductsState.error() = _ErrorSpecialProducts;
}
