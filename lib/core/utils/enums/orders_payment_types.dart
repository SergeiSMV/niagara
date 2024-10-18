import 'package:niagara_app/core/utils/gen/strings.g.dart';

enum OrdersPaymentTypes {
  unknown, // ошибка
  cash, // курьеру ("При получении")
  bankCard,
  sberPay,
  sbp;

  String toLocale() => switch (this) {
        cash => t.recentOrders.ordersPaymentTypes.inCash,
        bankCard => t.recentOrders.ordersPaymentTypes.byBankCard,
        sberPay => t.recentOrders.ordersPaymentTypes.sberbank,
        sbp => t.recentOrders.ordersPaymentTypes.sbp,
        _ => '',
      };

  static OrdersPaymentTypes toEnum(String value) {
    final formatted = value.toLowerCase().trim();

    if (formatted == t.recentOrders.paymentTypes.cash) {
      return OrdersPaymentTypes.cash;
    }
    if (formatted == t.recentOrders.paymentTypes.card) {
      return OrdersPaymentTypes.bankCard;
    }
    if (formatted == t.recentOrders.paymentTypes.sberbank) {
      return OrdersPaymentTypes.sberPay;
    }

    if (formatted == t.recentOrders.paymentTypes.sbp) {
      return OrdersPaymentTypes.sbp;
    }

    return OrdersPaymentTypes.unknown;
  }
}
