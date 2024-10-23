part of 'payment_method_selection_cubit.dart';

@freezed
class PaymentMethodSelectionState with _$PaymentMethodSelectionState {
  const factory PaymentMethodSelectionState.selected({
    required PaymentMethodGroup type,
    PaymentMethod? method,
  }) = _Selected;
}
