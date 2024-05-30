part of 'products_bloc.dart';

@freezed
class ProductsEvent with _$ProductsEvent {
  const factory ProductsEvent.loading({
    required bool isForceUpdate,
  }) = _LoadingEvent;

  const factory ProductsEvent.loadMore() = _LoadMoreEvent;

  const factory ProductsEvent.setSort({
    required ProductsSortType sort,
  }) = _SetSortEvent;
}
