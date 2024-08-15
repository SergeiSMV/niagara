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
