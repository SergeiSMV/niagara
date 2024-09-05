import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/common/domain/models/time_slot.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/payment_method_type.dart';
import 'package:niagara_app/core/utils/enums/placing_order_error_type.dart';
import 'package:niagara_app/core/utils/network/network_info.dart';
import 'package:niagara_app/features/order_placing/domain/models/tokenization_data.dart';
import 'package:niagara_app/features/order_placing/domain/use_cases/create_order_use_case.dart';

part 'create_order_state.dart';
part 'create_order_cubit.freezed.dart';

@injectable
class OrderCreationCubit extends Cubit<OrderCreationState> {
  OrderCreationCubit(
    this._networkInfo,
    this._createOrderUseCase,
  ) : super(const OrderCreationState.initial());

  final CreateOrderUseCase _createOrderUseCase;

  /// Нужен для проверки интернета.
  final INetworkInfo _networkInfo;

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

  bool checkDate() {
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

  bool checkRecipient() {
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

  bool checkPaymentMethod() {
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

  Future<bool> checkInternet() async {
    final bool hasInternet = await _networkInfo.hasConnection;

    if (!hasInternet) {
      emit(
        const OrderCreationState.error(
          type: OrderPlacingErrorType.noInternet,
        ),
      );
    }

    return hasInternet;
  }

  Future<void> placeOrder() async {
    emit(const OrderCreationState.initial());

    final bool isDataValid = await checkInternet() &&
        checkDate() &&
        checkRecipient() &&
        checkPaymentMethod();

    if (!isDataValid) return;

    emit(const OrderCreationState.loading());

    _createOrderUseCase(
      CreateOrderParams(
        deliveryDate: selectedDate!,
        timeSlot: selectedTimeSlot!,
        paymentMethod: paymentMethod!,
        comment: comment,
      ),
    ).fold(
      (failure) => emit(
        const OrderCreationState.error(
          type: OrderPlacingErrorType.unknown,
        ),
      ),
      (result) {
        switch (paymentMethod!) {
          case PaymentMethod.terminal:
          case PaymentMethod.cash:
            emit(const OrderCreationState.created());

          case PaymentMethod.bankCard:
          case PaymentMethod.sbp:
          case PaymentMethod.sberPay:
            emit(OrderCreationState.paymentRequired(data: result));
        }
      },
    );
  }
}
