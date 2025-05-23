part of 'orders_bloc.dart';

@freezed
class OrdersEvent with _$OrdersEvent {
  const factory OrdersEvent.loading({
    required bool isForceUpdate,
  }) = _LoadingEvent;

  const factory OrdersEvent.loadAll() = _LoadAllEvent;

  const factory OrdersEvent.loadMore() = _LoadMoreEvent;

  const factory OrdersEvent.loadPreview() = _LoadPreviewEvent;

  const factory OrdersEvent.setSort({
    required OrdersTypes sort,
  }) = _SetSortEvent;
}
