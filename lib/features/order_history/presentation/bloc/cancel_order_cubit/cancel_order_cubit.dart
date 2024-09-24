import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/order_history/domain/use_cases/cancel_order_use_case.dart';

part 'cancel_order_cubit.freezed.dart';
part 'cancel_order_state.dart';

@injectable
class CancelOrderCubit extends Cubit<CancelOrderState> {
  CancelOrderCubit(
    this._cancelOrderUseCase,
  ) : super(const CancelOrderState.initial());

  final CancelOrderUseCase _cancelOrderUseCase;

  void cancelOrder(String id) {
    emit(const CancelOrderState.loading());
    _cancelOrderUseCase(id).fold(
      (failure) => emit(const CancelOrderState.error()),
      (result) => result
          ? emit(const CancelOrderState.success())
          : emit(const CancelOrderState.error()),
    );
  }
}
