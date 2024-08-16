part of 'payments_cubit.dart';

@freezed
class PaymentsState with _$PaymentsState {
  const factory PaymentsState.initial() = _Initial;

  const factory PaymentsState.loading() = _Loading;

  const factory PaymentsState.success() = _Success;

  const factory PaymentsState.orderCanceled() = _Canceled;

  const factory PaymentsState.tokenizationError() = _TokenizationError;

  const factory PaymentsState.getConfirmationUrlError() =
      _GetConfirmationUrlError;

  const factory PaymentsState.confirmationError() = _ConfirmationError;

  const factory PaymentsState.paymentStatusError() = _PaymentStatusError;
}
