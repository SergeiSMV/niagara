part of 'evaluate_order_cubit.dart';

@freezed
class EvaluateOrderState with _$EvaluateOrderState {
  const factory EvaluateOrderState.initial() = _Initial;
  const factory EvaluateOrderState.loading() = _Loading;
  const factory EvaluateOrderState.success() = _Success;
  const factory EvaluateOrderState.error() = _Error;
}
