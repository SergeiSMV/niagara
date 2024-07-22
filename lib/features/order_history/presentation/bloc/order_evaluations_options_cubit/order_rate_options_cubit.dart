import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/order_history/domain/models/order_rate_option.dart';
import 'package:niagara_app/features/order_history/domain/use_cases/get_order_evaluations_options_use_case.dart';

part 'order_rate_options_cubit.freezed.dart';
part 'order_rate_options_state.dart';

@injectable
class OrderRateOptionsCubit extends Cubit<OrderRateOptionsState> {
  OrderRateOptionsCubit(
    this._getOrderRateOptionsUseCase,
  ) : super(const OrderRateOptionsState.loading());

  final GetOrderRateOptionsUseCase _getOrderRateOptionsUseCase;

  double rating = 5.0;
  List<OrderRateOption> options = [];
  String comment = '';

  void changeRating(double value) {
    rating = value;
    getOrderRateOptions();
  }

  Future<void> getOrderRateOptions() async {
    emit(const OrderRateOptionsState.loading());
    await _getOrderRateOptionsUseCase(rating.toInt()).fold(
      (failure) => emit(const OrderRateOptionsState.error()),
      (data) {
        if (data.isNotEmpty) {
          options = data;
          emit(OrderRateOptionsState.loaded(options: data));
        } else {
          emit(const OrderRateOptionsState.empty());
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
    emit(OrderRateOptionsState.loaded(options: updatedOptions));
  }

  List<String> returnOptionsIds() => options
      .where((option) => option.isSelected)
      .map((option) => option.id)
      .toList();
}
