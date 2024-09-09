import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Типы ошибок при проведении оплаты.
enum PaymentErrorType {
  /// Сервис проведения оплат недоступен.
  serviceUnavailable,

  /// Оплата не была подтверждена из-за ошибки или отмены польщзователем.
  notConfirmed,

  /// Ошибка получения статуса оплаты.
  ///
  /// **Важно**: платёж всё ещё мог быть успешно заверешн. Эта ошибка говорит
  /// лишь о том, что не удалось получить статус оплаты.
  statusError,

  /// Ошибка создания платежа на сервере (информация о подтверждении платежа
  /// не сможет быть получена).
  notCreated;

  /// Преобразует тип ошибки оплаты в текст ошибки.
  String get toErrorText => switch (this) {
        PaymentErrorType.serviceUnavailable =>
          t.errors.serviceUnavailable.title,
        PaymentErrorType.notConfirmed => t.errors.notConfirmed.title,
        PaymentErrorType.notCreated => t.errors.paymentError.title,
        PaymentErrorType.statusError => t.errors.statusError.title,
      };

  /// Преобразует тип ошибки оплаты в опциональное описание ошибки.
  String? get toErrorDescription => switch (this) {
        PaymentErrorType.serviceUnavailable =>
          t.errors.serviceUnavailable.description,
        PaymentErrorType.notConfirmed => t.errors.notConfirmed.description,
        PaymentErrorType.notCreated => t.errors.paymentError.description,
        PaymentErrorType.statusError => t.errors.statusError.description,
      };
}
