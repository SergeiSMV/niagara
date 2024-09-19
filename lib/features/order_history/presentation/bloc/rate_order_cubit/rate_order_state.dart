part of 'rate_order_cubit.dart';

@freezed
class RateOrderState with _$RateOrderState {
  const factory RateOrderState.initial() = _Initial;
  const factory RateOrderState.loading() = _Loading;
  const factory RateOrderState.success() = _Success;
  const factory RateOrderState.error() = _Error;
}
