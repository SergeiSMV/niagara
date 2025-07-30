import '../../../../core/utils/gen/strings.g.dart';

enum NotificationsTypes {
  all,
  orders,
  offers,
  system,
  product_group,
  product;

  String toLocale() => switch (this) {
        NotificationsTypes.all => t.notifications.pushTypes.all,
        NotificationsTypes.orders => t.notifications.pushTypes.orders,
        NotificationsTypes.offers => t.notifications.pushTypes.stocks,
        NotificationsTypes.system => t.notifications.pushTypes.system,
        NotificationsTypes.product_group =>
          t.notifications.pushTypes.product_group,
        NotificationsTypes.product => t.notifications.pushTypes.product,
      };
}
