import 'package:niagara_app/core/utils/gen/strings.g.dart';

enum RecentOrderStatus {
  goingTo,
  onWay,
  received,
  cancelled;

  String toLocale() => switch (this) {
        RecentOrderStatus.goingTo => t.recentOrders.statuses.goingTo,
        RecentOrderStatus.onWay => t.recentOrders.statuses.onWay,
        RecentOrderStatus.received => t.recentOrders.statuses.received,
        RecentOrderStatus.cancelled => t.recentOrders.statuses.cancelled,
      };
}
