import 'package:niagara_app/core/utils/gen/strings.g.dart';

enum OrdersPaymentTypes {
  cash, // наличными
  card, // картой курьеру
  online; // онлайн через приложение

  String toLocale() => switch (this) {
        cash => t.recentOrders.ordersPaymentTypes.inCash,
        card => t.recentOrders.ordersPaymentTypes.byBankCard,
        online => t.recentOrders.ordersPaymentTypes.byBankCard,
      };

  static OrdersPaymentTypes toEnum(String value) => switch (value) {
        'CASH' => OrdersPaymentTypes.cash,
        'CARD' => OrdersPaymentTypes.card,
        'ONLINE' => OrdersPaymentTypes.online,
        _ => OrdersPaymentTypes.cash,
      };
}
