part of 'orders_bloc.dart';

@freezed
class OrdersState with _$OrdersState {
  const factory OrdersState.loading({
     List<UserOrder>? preview,
  }) = _Loading;

  const factory OrdersState.loaded({
    required List<UserOrder> orders,
     List<UserOrder>? preview,
  }) = _Loaded;

  const factory OrdersState.error() = _Error;
}
