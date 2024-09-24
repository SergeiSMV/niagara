import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/order_history/domain/use_cases/repeat_order_use_case.dart';

part 'repeat_order_state.dart';
part 'repeat_order_cubit.freezed.dart';

@injectable
class RepeatOrderCubit extends Cubit<RepeatOrderState> {
  RepeatOrderCubit(this._repeatOrderUseCase)
      : super(const RepeatOrderState.initial());

  final RepeatOrderUseCase _repeatOrderUseCase;

  void repeatOrder(String id) {
    emit(const RepeatOrderState.loading());
    _repeatOrderUseCase(id).fold(
      (failure) => emit(const RepeatOrderState.error()),
      (result) => result
          ? emit(const RepeatOrderState.success())
          : emit(const RepeatOrderState.error()),
    );
  }
}
