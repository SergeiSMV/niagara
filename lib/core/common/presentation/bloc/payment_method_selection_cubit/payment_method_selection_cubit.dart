import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/payment_method_type.dart';

part 'payment_method_selection_state.dart';
part 'payment_method_selection_cubit.freezed.dart';

/// Кубит для выбора метода оплаты.
///
/// Используется только для менеджмента состояния виджета выбора метода оплаты.
///
/// Не содержит бизнес-логики и не влияет на процесс создания заказа.
@injectable
class PaymentMethodSelectionCubit extends Cubit<PaymentMethodSelectionState> {
  PaymentMethodSelectionCubit({
    @factoryParam this.allowedMethods = PaymentMethod.values,
  }) : super(
          const PaymentMethodSelectionState.selected(
            type: PaymentMethodGroup.online,
          ),
        );

  /// Список доступных методов оплаты.
  ///
  /// По умолчанию доступны все методы оплаты.
  final List<PaymentMethod> allowedMethods;

  /// Индикатор, выбран ли тип оплаты "онлайн".
  ///
  /// `true` по умолчанию.
  bool get isOnline => state.type == PaymentMethodGroup.online;

  /// Индикатор, выбран ли способ оплаты.
  bool get selected => state.method != null;

  /// Устанавливает __метод__ оплаты.
  ///
  /// Если устанавливается уже выбранный метод оплаты, происходит сброс выбора.
  void selectPaymentMethod(PaymentMethod method) =>
      emit(state.copyWith(method: state.method == method ? null : method));

  /// Устанавливает __тип__ оплаты (онлайн или курьеру).
  ///
  /// Нужен для переключения вкладок. Не влияет на выбранный __метод__ оплаты.
  void selectPaymentMethodType(PaymentMethodGroup type) =>
      emit(state.copyWith(type: type));
}
