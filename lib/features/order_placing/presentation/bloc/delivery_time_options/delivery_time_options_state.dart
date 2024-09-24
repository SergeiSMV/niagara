part of 'delivery_time_options_cubit.dart';

@freezed
class DeliveryTimeOptionsState with _$DeliveryTimeOptionsState {
  const factory DeliveryTimeOptionsState.loading() = _Loading;

  const factory DeliveryTimeOptionsState.loaded(
    List<DeliveryTimeOptions> options,
  ) = _Loaded;

  const factory DeliveryTimeOptionsState.error() = _Error;

  const factory DeliveryTimeOptionsState.empty() = _Empty;
}
