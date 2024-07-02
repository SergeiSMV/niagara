part of 'catalog_search_bloc.dart';

@freezed
class CatalogSearchEvent with _$CatalogSearchEvent {
  const factory CatalogSearchEvent.search({required String text}) = _Search;

  const factory CatalogSearchEvent.sort({required ProductsSortType sortType}) =
      _Sort;
}
