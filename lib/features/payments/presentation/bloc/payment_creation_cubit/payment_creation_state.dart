part of 'payment_creation_cubit.dart';

@freezed
class PaymentCreationState with _$PaymentCreationState {
  /// Начальное состояние.
  const factory PaymentCreationState.initial() = _Initial;

  /// Состояние загрузки (заказ создаётся, ожидание ответа).
  const factory PaymentCreationState.loading() = _Loading;

  /// Заказ создан на сервере, ожидание оплаты (перенаправление на страницу
  /// [PaymentInstructionsRoute]).
  const factory PaymentCreationState.created({
    required TokenizationData data,
  }) = _Created;

  /// Ошибка создания заказа на сервере.
  const factory PaymentCreationState.error({
    required OrderPlacingErrorType type,
  }) = _Error;
}
