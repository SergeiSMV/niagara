import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/common/domain/models/time_slot.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/payment_method_type.dart';
import 'package:niagara_app/core/utils/enums/placing_order_error_type.dart';
import 'package:niagara_app/core/utils/network/network_info.dart';

part 'order_placing_state.dart';
part 'order_placing_cubit.freezed.dart';

@injectable
class OrderPlacingCubit extends Cubit<OrderPlacingState> {
  OrderPlacingCubit(this._networkInfo)
      : super(const OrderPlacingState.initial());

  /// Нужен для проверки интернета.
  final NetworkInfo _networkInfo;

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
        const OrderPlacingState.error(
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
        const OrderPlacingState.error(
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
        const OrderPlacingState.error(
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
        const OrderPlacingState.error(
          type: OrderPlacingErrorType.noInternet,
        ),
      );
    }

    return hasInternet;
  }

  Future<void> placeOrder() async {
    final bool isDataValid = await checkInternet() &&
        checkDate() &&
        checkRecipient() &&
        checkPaymentMethod();

    if (!isDataValid) return;
  }
}
