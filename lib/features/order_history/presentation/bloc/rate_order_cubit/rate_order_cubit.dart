import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../core/core.dart';
import '../../../domain/use_cases/rate_order_use_case.dart';

part 'rate_order_cubit.freezed.dart';
part 'rate_order_state.dart';

/// Кубит для оценки заказа
@injectable
class RateOrderCubit extends Cubit<RateOrderState> {
  RateOrderCubit(
    this._rateOrderUseCase,
  ) : super(const RateOrderState.initial());

  /// Кейс для оценки заказа
  final RateOrderUseCase _rateOrderUseCase;

  /// Оценка заказа
  Future<void> rateOrder({
    required String id,
    required double rating,
    required String comment,
    required List<String> optionsIds,
  }) async {
    emit(const RateOrderState.loading());
    await _rateOrderUseCase(
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
