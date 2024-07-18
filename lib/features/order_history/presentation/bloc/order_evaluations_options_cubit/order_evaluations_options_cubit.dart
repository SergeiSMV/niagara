import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/order_history/domain/models/order_evaluation_option.dart';
import 'package:niagara_app/features/order_history/domain/use_cases/get_order_evaluations_options_use_case.dart';

part 'order_evaluations_options_state.dart';
part 'order_evaluations_options_cubit.freezed.dart';

@injectable
class OrderEvaluationsOptionsCubit extends Cubit<OrderEvaluationsOptionsState> {
  OrderEvaluationsOptionsCubit(
    this._getOrderEvaluationsOptionsUseCase,
  ) : super(const OrderEvaluationsOptionsState.loading());

  final GetOrderEvaluationsOptionsUseCase _getOrderEvaluationsOptionsUseCase;

  double rating = 5.0;
  List<OrderEvaluationOption> options = [];
  String comment = '';

  void changeRating(double value) {
    rating = value;
    getOrderEvaluationsOptions();
  }

  Future<void> getOrderEvaluationsOptions() async {
    emit(const OrderEvaluationsOptionsState.loading());
    await _getOrderEvaluationsOptionsUseCase(rating.toInt().toString()).fold(
      (failure) => emit(const OrderEvaluationsOptionsState.error()),
      (data) {
        if (data.isNotEmpty) {
          options = data;
          emit(OrderEvaluationsOptionsState.loaded(options: data));
        } else {
          emit(const OrderEvaluationsOptionsState.empty());
        }
      },
    );
  }

  void selectOption(String id) {
    final updatedOptions = options.map((option) {
      if (option.id == id) {
        return option.copyWith(isSelected: !option.isSelected);
      }
      return option;
    }).toList();

    options = updatedOptions;
    emit(OrderEvaluationsOptionsState.loaded(options: updatedOptions));
  }
}
