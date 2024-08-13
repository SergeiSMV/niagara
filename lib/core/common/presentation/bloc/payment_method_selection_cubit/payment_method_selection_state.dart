part of 'payment_method_selection_cubit.dart';

@freezed
class PaymentMethodSelectionState with _$PaymentMethodSelectionState {
  const factory PaymentMethodSelectionState.online({
    OnlinePaymentMethod? paymentMethod,
  }) = _OnlineSelected;

  const factory PaymentMethodSelectionState.courier({
    CourierPaymentMethod? paymentMethod,
  }) = _CourierSelected;

  /// Индикатор, выбран ли тип оплаты "онлайн".
  bool get isOnline => maybeWhen(
        online: (_) => true,
        courier: (_) => false,
        orElse: () => false,
      );
}
