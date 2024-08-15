part of 'create_order_cubit.dart';

@freezed
class OrderCreationState with _$OrderCreationState {
  const factory OrderCreationState.initial() = _Initial;

  const factory OrderCreationState.loading() = _Loading;

  const factory OrderCreationState.created() = _Created;

  const factory OrderCreationState.error({
    required OrderPlacingErrorType type,
  }) = _Error;
}
