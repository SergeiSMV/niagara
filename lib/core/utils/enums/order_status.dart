import 'package:niagara_app/core/utils/gen/strings.g.dart';

enum OrderStatus {
  goingTo,
  onWay,
  received,
  cancelled;

  String toLocale() => switch (this) {
        goingTo => t.recentOrders.statuses.goingTo,
        onWay => t.recentOrders.statuses.onWay,
        received => t.recentOrders.statuses.received,
        cancelled => t.recentOrders.statuses.cancelled,
      };

  static OrderStatus toEnum(String value) {
    if (value == t.recentOrders.statuses.goingTo) return OrderStatus.goingTo;
    if (value == t.recentOrders.statuses.onWay) return OrderStatus.onWay;
    if (value == t.recentOrders.statuses.received) return OrderStatus.received;
    if (value == t.recentOrders.statuses.cancelled) {
      return OrderStatus.cancelled;
    }
    return OrderStatus.goingTo;
  }
}
