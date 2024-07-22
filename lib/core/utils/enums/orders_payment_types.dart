import 'package:niagara_app/core/utils/gen/strings.g.dart';

enum OrdersPaymentTypes {
  unknown,
  cash, // наличными
  card, // картой курьеру
  online; // онлайн через приложение

  String toLocale() => switch (this) {
        cash => t.recentOrders.ordersPaymentTypes.inCash,
        card => t.recentOrders.ordersPaymentTypes.byBankCard,
        online => t.recentOrders.ordersPaymentTypes.byBankCard,
        _ => '',
      };

  static OrdersPaymentTypes toEnum(String value) {
    if (value == t.recentOrders.paymentTypes.cash) {
      return OrdersPaymentTypes.cash;
    }
    if (value == t.recentOrders.paymentTypes.card) {
      return OrdersPaymentTypes.card;
    }
    if (value == t.recentOrders.paymentTypes.online) {
      return OrdersPaymentTypes.online;
    }
    return OrdersPaymentTypes.unknown;
  }
}
