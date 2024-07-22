import 'package:niagara_app/core/utils/gen/strings.g.dart';

enum OrdersTypes {
  delivery,
  finish,
  cancel;

  String toLocale() => switch (this) {
        finish => t.recentOrders.ordersFilter.finish,
        cancel => t.recentOrders.ordersFilter.cancel,
        delivery => t.recentOrders.ordersFilter.delivery,
      };
}
