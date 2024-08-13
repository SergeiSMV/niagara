import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/payment_method_type.dart';

part 'payment_method_selection_state.dart';
part 'payment_method_selection_cubit.freezed.dart';

/// Кубит для выбора метода оплаты.
@injectable
class PaymentMethodSelectionCubit extends Cubit<PaymentMethodSelectionState> {
  PaymentMethodSelectionCubit()
      : super(
          const PaymentMethodSelectionState.online(),
        );

  /// Индикатор, выбран ли способ оплаты.
  bool get selected => state.maybeWhen(
        online: (paymentMethod) => paymentMethod != null,
        courier: (paymentMethod) => paymentMethod != null,
        orElse: () => false,
      );

  /// Устанавливает тип оплаты - онлайн или курьеру.
  void selectPaymentMethodType(PaymentMethodType type) {
    final PaymentMethodType current = state.maybeWhen(
      online: (_) => PaymentMethodType.online,
      courier: (_) => PaymentMethodType.courier,
      orElse: () => PaymentMethodType.online,
    );

    if (type == current) return;
    emit(
      type == PaymentMethodType.online
          ? const PaymentMethodSelectionState.online()
          : const PaymentMethodSelectionState.courier(),
    );
  }

  /// Выбирает метод оплаты онлайн - картой, СБП или СберПей.
  void selectOnlinePaymentMethod(OnlinePaymentMethod? paymentMethod) {
    if (state is! _OnlineSelected) return;
    if ((state as _OnlineSelected).paymentMethod == paymentMethod) return;

    emit(
      PaymentMethodSelectionState.online(paymentMethod: paymentMethod),
    );
  }

  /// Выбирает метод оплаты курьеру - наличными или через терминал.
  void selectCourierPaymentMethod(CourierPaymentMethod? paymentMethod) {
    if (state is! _CourierSelected) return;
    if ((state as _CourierSelected).paymentMethod == paymentMethod) return;

    emit(
      PaymentMethodSelectionState.courier(paymentMethod: paymentMethod),
    );
  }
}
