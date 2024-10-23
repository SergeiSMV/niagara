import 'package:yookassa_payments_flutter/models/payment_method_types.dart'
    as yk;

/// Способы оплаты.
///
/// - [bankCard] - оплата банковской картой онлайн.
/// - [sbp] - оплата через СБП.
/// - [sberPay] - оплата через СберПей.
/// - [cash] - оплата курьеру.
enum PaymentMethod {
  bankCard,
  sbp,
  sberPay,
  cash;

  factory PaymentMethod.fromString(String value) {
    switch (value) {
      case 'bank_card':
        return PaymentMethod.bankCard;

      case 'sbp':
        return PaymentMethod.sbp;

      case 'sberbank':
        return PaymentMethod.sberPay;

      case 'terminal':
      case 'cash':
        return PaymentMethod.cash;

      default:
        throw ArgumentError('Unknown payment method: $value');
    }
  }

  yk.PaymentMethod toYooKassa() {
    switch (this) {
      case PaymentMethod.bankCard:
        return yk.PaymentMethod.bankCard;
      case PaymentMethod.sbp:
        return yk.PaymentMethod.sbp;
      case PaymentMethod.sberPay:
        return yk.PaymentMethod.sberbank;
      default:
        throw ArgumentError('Unsupported payment method: $this');
    }
  }

  /// Список методов для оплаты онлайн.
  static List<PaymentMethod> get onlineMethods => [
        PaymentMethod.bankCard,
        PaymentMethod.sbp,
        PaymentMethod.sberPay,
      ];

  /// Список методов для оплаты курьеру.
  static List<PaymentMethod> get courierMethods => [
        PaymentMethod.cash,
      ];

  /// Возвращает `true`, если оплата происходит онлайн.
  bool get isOnline =>
      this == PaymentMethod.bankCard ||
      this == PaymentMethod.sbp ||
      this == PaymentMethod.sberPay;

  @override
  String toString() {
    switch (this) {
      case PaymentMethod.bankCard:
        return 'bank_card';
      case PaymentMethod.sbp:
        return 'sbp';
      case PaymentMethod.sberPay:
        return 'sberbank';
      case PaymentMethod.cash:
        return 'cash';
    }
  }
}

/// Группы методов оплаты.
///
/// Нужны для переключения между вкладками "онлайн" и "курьеру" при выборе
/// метода оплаты.
enum PaymentMethodGroup {
  online,
  courier,
}
