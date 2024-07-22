import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/order_history/domain/use_cases/evaluate_order_use_case.dart';

part 'rate_order_cubit.freezed.dart';
part 'rate_order_state.dart';

@injectable
class RateOrderCubit extends Cubit<RateOrderState> {
  RateOrderCubit(
    this._rateOrderUseCase,
  ) : super(const RateOrderState.initial());

  final RateOrderUseCase _rateOrderUseCase;

  void rateOrder({
    required String id,
    required double rating,
    required String comment,
    required List<String> optionsIds,
  }) {
    emit(const RateOrderState.loading());
    _rateOrderUseCase(
      RateOrderParams(
        id: id,
        rating: rating.toInt(),
        comment: comment,
        optionsIds: optionsIds,
      ),
    ).fold(
      (failure) => emit(const RateOrderState.error()),
      (result) => result
          ? emit(const RateOrderState.success())
          : emit(const RateOrderState.error()),
    );
  }
}
