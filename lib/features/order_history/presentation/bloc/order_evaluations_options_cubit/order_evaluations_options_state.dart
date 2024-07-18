part of 'order_evaluations_options_cubit.dart';

@freezed
class OrderEvaluationsOptionsState with _$OrderEvaluationsOptionsState {
  const factory OrderEvaluationsOptionsState.loading() = _Loading;

  const factory OrderEvaluationsOptionsState.loaded({
    required List<OrderEvaluationOption> options,
  }) = _Loaded;

  const factory OrderEvaluationsOptionsState.empty() = _Empty;

  const factory OrderEvaluationsOptionsState.error() = _Error;
}
