import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/common/domain/models/time_slot.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/payment_method_type.dart';
import 'package:niagara_app/core/utils/enums/placing_order_error_type.dart';
import 'package:niagara_app/features/order_placing/domain/models/tokenization_data.dart';
import 'package:niagara_app/features/order_placing/domain/use_cases/create_order_use_case.dart';

part 'create_order_state.dart';
part 'create_order_cubit.freezed.dart';

@injectable
class OrderCreationCubit extends Cubit<OrderCreationState> {
  OrderCreationCubit(
    this._createOrderUseCase,
  ) : super(const OrderCreationState.initial()) {
    // paymentMethod = PaymentMethod.sbp;
  }

  final CreateOrderUseCase _createOrderUseCase;

  /// Выбранная дата доставки.
  DateTime? selectedDate;

  /// Выбранный временной слот для доставки.
  TimeSlot? selectedTimeSlot;

  /// Комментарий к заказу.
  String? comment;

  /// Выбран ли получатель заказа.
  bool? recipientSet;

  /// Выбранный способ оплаты.
  PaymentMethod? paymentMethod;

  /// Индикатор загрузки.
  bool get isLoading =>
      state.maybeWhen(loading: () => true, orElse: () => false);

  /// Проверяет, выбраны ли дата доставки и временной слот.
  bool _checkDate() {
    final bool selected = selectedDate != null && selectedTimeSlot != null;

    if (!selected) {
      emit(
        const OrderCreationState.error(
          type: OrderPlacingErrorType.noDeliveryDate,
        ),
      );
    }

    return selected;
  }

  /// Проверяет, выбран ли получатель заказа.
  bool _checkRecipient() {
    final bool selected = recipientSet != null && recipientSet!;

    if (!selected) {
      emit(
        const OrderCreationState.error(
          type: OrderPlacingErrorType.noRecipientData,
        ),
      );
    }

    return selected;
  }

  /// Проверяет, выбран ли способ оплаты.
  bool _checkPaymentMethod() {
    final bool selected = paymentMethod != null;

    if (!selected) {
      emit(
        const OrderCreationState.error(
          type: OrderPlacingErrorType.noPaymentMethod,
        ),
      );
    }

    return selected;
  }

  /// Оформляет заказ.
  ///
  /// Сначала происходит валидация всех необходимых данных, затем создаётся
  /// заказ.
  ///
  /// [allowZeroPrice] - отменяет проверку на метод оплаты при заказе с нулевой
  /// суммой, т.к. в его выборе нет смысла.
  Future<void> placeOrder({bool allowZeroPrice = false}) async {
    emit(const OrderCreationState.initial());

    final bool isDataValid = _checkRecipient() &&
        _checkDate() &&
        (allowZeroPrice || _checkPaymentMethod());

    if (allowZeroPrice) paymentMethod = PaymentMethod.cash;

    if (!isDataValid) return;

    emit(const OrderCreationState.loading());

    await _createOrderUseCase(
      CreateOrderParams(
        deliveryDate: selectedDate!,
        timeSlot: selectedTimeSlot!,
        paymentMethod: paymentMethod!,
        comment: comment,
      ),
    ).fold(
      (failure) {
        late final OrderPlacingErrorType errorType;

        if (failure is NoInternetFailure) {
          errorType = OrderPlacingErrorType.noInternet;
        } else {
          errorType = OrderPlacingErrorType.unknown;
        }

        emit(OrderCreationState.error(type: errorType));
      },
      (result) {
        if (paymentMethod!.isOnline) {
          emit(OrderCreationState.paymentRequired(data: result));
        } else {
          emit(const OrderCreationState.created());
        }
      },
    );
  }
}
