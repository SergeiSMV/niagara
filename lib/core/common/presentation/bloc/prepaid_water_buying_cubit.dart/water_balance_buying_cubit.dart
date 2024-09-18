import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/core.dart';

/// Кубит для управления количеством заказываемой предоплатной воды.
@injectable
class OrderWaterAmountCubit extends Cubit<int> {
  OrderWaterAmountCubit() : super(1);

  /// Увеличить.
  void increment() => emit(state + 1);

  /// Уменьшить.
  void decrement() => state > 1 ? emit(state - 1) : null;
}
