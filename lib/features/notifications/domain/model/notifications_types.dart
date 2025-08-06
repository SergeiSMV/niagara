import '../../../../core/utils/gen/strings.g.dart';

enum NotificationsTypes {
  all,
  orders,
  offers,
  system,
  product_group,
  get_rating,
  call,
  product;

  String toLocale() => switch (this) {
        NotificationsTypes.all => t.notifications.pushTypes.all,
        NotificationsTypes.orders => t.notifications.pushTypes.orders,
        NotificationsTypes.offers => t.notifications.pushTypes.stocks,
        NotificationsTypes.system => t.notifications.pushTypes.system,
        NotificationsTypes.product_group =>
          t.notifications.pushTypes.product_group,
        NotificationsTypes.get_rating => t.notifications.pushTypes.get_rating,
        NotificationsTypes.call => t.notifications.pushTypes.call,
        NotificationsTypes.product => t.notifications.pushTypes.product,
      };
}
