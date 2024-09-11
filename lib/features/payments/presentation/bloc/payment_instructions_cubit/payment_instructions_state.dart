part of 'payment_instructions_cubit.dart';

@freezed
class PaymentInstructionsState with _$PaymentInstructionsState {
  /// Начальное состояние.
  ///
  /// Пользователь должен следовать инструкциям на экране.
  const factory PaymentInstructionsState.initial() = _Initial;

  /// Состояние загрузки.
  const factory PaymentInstructionsState.loading() = _Loading;

  /// Успешное завершение оплаты.
  const factory PaymentInstructionsState.success() = _Success;

  /// Отмена заказа.
  const factory PaymentInstructionsState.orderCanceled() = _Canceled;

  /// Ошибка на одном из этапов процесса оплаты.
  const factory PaymentInstructionsState.error({
    required PaymentErrorType type,
  }) = _Error;
}
