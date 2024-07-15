import 'package:niagara_app/core/utils/gen/strings.g.dart';

enum NotificationsTypes {
  all,
  orders,
  offers,
  system;

  String toLocale() => switch (this) {
        NotificationsTypes.all => t.notifications.pushTypes.all,
        NotificationsTypes.orders => t.notifications.pushTypes.orders,
        NotificationsTypes.offers => t.notifications.pushTypes.stocks,
        NotificationsTypes.system => t.notifications.pushTypes.system,
      };
}
