part of 'orders_bloc.dart';

@freezed
class OrdersState with _$OrdersState {
  const factory OrdersState.loading() = _Loading;

  const factory OrdersState.loaded({
    required List<UserOrder> orders,
  }) = _Loaded;

  const factory OrdersState.error() = _Error;
}
