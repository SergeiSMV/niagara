/// Возможные статусы платежа.
/// - `pending` - платёж создан и ожидает подтверждения от пользователя.
/// - `succeeded` - платёж успешно завершён.
/// - `canceled` - платёж отменён или произошла ошибка.
enum PaymentStatus {
  pending,
  succeeded,
  canceled;

  static PaymentStatus fromString(String status) {
    switch (status) {
      case 'pending':
        return PaymentStatus.pending;
      case 'succeeded':
        return PaymentStatus.succeeded;
      case 'canceled':
        return PaymentStatus.canceled;
      default:
        throw ArgumentError('Unknown payment status: $status');
    }
  }
}
