part of 'catalog_search_bloc.dart';

@freezed
class CatalogSearchState with _$CatalogSearchState {
  const factory CatalogSearchState.initial() = _Initial;

  const factory CatalogSearchState.loading() = _Loading;

  const factory CatalogSearchState.loaded({
    required List<Product> products,
  }) = _Loaded;

  const factory CatalogSearchState.error() = _Error;
}
