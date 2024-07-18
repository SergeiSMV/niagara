import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/order_history/domain/use_cases/evaluate_order_use_case.dart';

part 'evaluate_order_state.dart';
part 'evaluate_order_cubit.freezed.dart';

@injectable
class EvaluateOrderCubit extends Cubit<EvaluateOrderState> {
  EvaluateOrderCubit(
    this._evaluateOrderUseCase,
  ) : super(const EvaluateOrderState.initial());

  final EvaluateOrderUseCase _evaluateOrderUseCase;

  void estimate({
    required String id,
    required String rating,
    required String description,
    required List<String> optionsIds,
  }) {
    emit(const EvaluateOrderState.loading());
    _evaluateOrderUseCase(
      EvaluateOrderParams(
        id: id,
        rating: rating,
        description: description,
        optionsIds: optionsIds,
      ),
    ).fold(
      (failure) => emit(const EvaluateOrderState.error()),
      (result) => result
          ? emit(const EvaluateOrderState.success())
          : emit(const EvaluateOrderState.error()),
    );
  }
}
