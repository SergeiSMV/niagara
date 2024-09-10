import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Типы ошибок при проведении оплаты.
enum PaymentErrorType {
  /// Сервис проведения оплат недоступен.
  serviceUnavailable,

  /// Оплата не была подтверждена из-за ошибки или отмены пользователем.
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
        serviceUnavailable => t.errors.serviceUnavailable.title,
        notConfirmed => t.errors.notConfirmed.title,
        notCreated => t.errors.paymentError.title,
        statusError => t.errors.statusError.title,
      };

  /// Преобразует тип ошибки оплаты в опциональное описание ошибки.
  String? get toErrorDescription => switch (this) {
        serviceUnavailable => t.errors.serviceUnavailable.description,
        notConfirmed => t.errors.notConfirmed.description,
        notCreated => t.errors.paymentError.description,
        statusError => t.errors.statusError.description,
      };
}
