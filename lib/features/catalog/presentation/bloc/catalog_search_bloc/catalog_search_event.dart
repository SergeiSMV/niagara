part of 'catalog_search_bloc.dart';

@freezed
class CatalogSearchEvent with _$CatalogSearchEvent {
  const factory CatalogSearchEvent.search({
    required String text,
    required bool isForceUpdate,
  }) = _Search;

  const factory CatalogSearchEvent.sort({required ProductsSortType sortType}) =
      _Sort;

  const factory CatalogSearchEvent.loadMore() = _LoadMore;
}
