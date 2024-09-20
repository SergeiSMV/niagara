part of 'order_rate_options_cubit.dart';

@freezed
class OrderRateOptionsState with _$OrderRateOptionsState {
  const factory OrderRateOptionsState.loading() = _Loading;

  const factory OrderRateOptionsState.loaded({
    required List<OrderRateOption> options,
  }) = _Loaded;

  const factory OrderRateOptionsState.empty() = _Empty;

  const factory OrderRateOptionsState.error() = _Error;
}
