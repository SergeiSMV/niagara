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
}
