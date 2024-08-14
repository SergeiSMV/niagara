part of 'order_placing_cubit.dart';

@freezed
class OrderPlacingState with _$OrderPlacingState {
  const factory OrderPlacingState.initial() = _Initial;

  const factory OrderPlacingState.loading() = _Loading;

  const factory OrderPlacingState.created() = _Created;

  const factory OrderPlacingState.error({
    required OrderPlacingErrorType type,
  }) = _Error;
}
