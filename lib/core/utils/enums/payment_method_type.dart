import 'package:yookassa_payments_flutter/models/payment_method_types.dart'
    as yk;

/// Способы оплаты.
///
/// - [bankCard] - оплата банковской картой онлайн.
/// - [sbp] - оплата через СБП.
/// - [sberPay] - оплата через СберПей.
/// - [cash] - оплата наличными курьеру.
/// - [terminal] - оплата через терминал курьеру.
enum PaymentMethod {
  bankCard,
  sbp,
  sberPay,
  cash,
  terminal;

  factory PaymentMethod.fromString(String value) {
    switch (value) {
      case 'bank_card':
        return PaymentMethod.bankCard;
      case 'sbp':
        return PaymentMethod.sbp;
      case 'sberbank':
        return PaymentMethod.sberPay;
      case 'cash':
        return PaymentMethod.cash;
      case 'terminal':
        return PaymentMethod.terminal;
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
      case PaymentMethod.terminal:
        return 'terminal';
    }
  }
}

/// Типы методов оплаты.
///
/// Нужны для переключения между вкладками "онлайн" и "курьеру" при выборе
/// метода оплаты.
enum PaymentMethodType {
  online,
  courier,
}
