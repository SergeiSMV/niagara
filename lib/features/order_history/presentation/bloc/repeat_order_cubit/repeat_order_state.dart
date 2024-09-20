part of 'repeat_order_cubit.dart';

@freezed
class RepeatOrderState with _$RepeatOrderState {
  const factory RepeatOrderState.initial() = _Initial;
  const factory RepeatOrderState.loading() = _Loading;
  const factory RepeatOrderState.success() = _Success;
  const factory RepeatOrderState.error() = _Error;
}
