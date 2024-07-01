part of 'products_bloc.dart';

@freezed
class ProductsEvent with _$ProductsEvent {
  const factory ProductsEvent.loading({
    required bool isForceUpdate,
    required List<FilterProperty> filters,
  }) = _LoadingEvent;

  const factory ProductsEvent.loadMore({
    required List<FilterProperty> filters,
  }) = _LoadMoreEvent;

  const factory ProductsEvent.setSort({
    required ProductsSortType sort,
    required List<FilterProperty> filters,
  }) = _SetSortEvent;
}
