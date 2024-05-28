part of 'products_bloc.dart';

@freezed
class ProductsState with _$ProductsState {
  const factory ProductsState.loading() = _Loading;

  const factory ProductsState.loaded({
   required List<Product> products,
  }) = _Loaded;

  const factory ProductsState.error() = _Error;
}
