part of 'payments_cubit.dart';

@freezed
class PaymentsState with _$PaymentsState {
  /// Начальное состояние.
  ///
  /// Пользователь должен следовать инструкциям на экране.
  const factory PaymentsState.initial() = _Initial;

  /// Состояние загрузки.
  const factory PaymentsState.loading() = _Loading;

  /// Успешное завершение оплаты.
  const factory PaymentsState.success() = _Success;

  /// Отмена заказа.
  const factory PaymentsState.orderCanceled() = _Canceled;

  /// Ошибка на одном из этапов процесса оплаты.
  const factory PaymentsState.error({
    required PaymentErrorType type,
  }) = _Error;
}
