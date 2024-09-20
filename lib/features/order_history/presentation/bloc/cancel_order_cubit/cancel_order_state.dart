part of 'cancel_order_cubit.dart';

@freezed
class CancelOrderState with _$CancelOrderState {
  const factory CancelOrderState.initial() = _Initial;
  const factory CancelOrderState.loading() = _Loading;
  const factory CancelOrderState.success() = _Success;
  const factory CancelOrderState.error() = _Error;
}
