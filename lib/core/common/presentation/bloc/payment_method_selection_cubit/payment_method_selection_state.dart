part of 'payment_method_selection_cubit.dart';

@freezed
class PaymentMethodSelectionState with _$PaymentMethodSelectionState {
  const factory PaymentMethodSelectionState.selected({
    required PaymentMethodType type,
    PaymentMethod? method,
  }) = _Selected;
}
