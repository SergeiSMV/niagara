/// Ошибки при оформлении заказа.
enum OrderPlacingErrorType {
  /// Не указаны данные получателя.
  noRecipientData,

  /// Не указаны дата и время доставки, если они требуются.
  noDeliveryDate,

  /// Не указан тип оплаты.
  noPaymentMethod,

  /// Нет интернета.
  noInternet,

  /// Неизвестная ошибка.
  unknown,
}
