/// Возможные статусы платежа.
/// - `pending` - платёж создан и ожидает подтверждения от пользователя.
/// - `succeded` - платёж успешно завершён.
/// - `canceled` - платёж отменён или произошла ошибка.
enum PaymentStatus {
  pending,
  succeded,
  canceled;

  static PaymentStatus fromString(String status) {
    switch (status) {
      case 'pending':
        return PaymentStatus.pending;
      case 'succeded':
        return PaymentStatus.succeded;
      case 'canceled':
        return PaymentStatus.canceled;
      default:
        throw ArgumentError('Unknown payment status: $status');
    }
  }
}
