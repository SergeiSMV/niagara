import '../../../../core/utils/gen/strings.g.dart';

/// Enum для типов уведомлений
enum NotificationsTypes {
  /// Все уведомления
  all,

  /// Уведомления о заказах
  orders,

  /// Уведомления о предложениях
  offers,

  /// Системные уведомления
  system,

  /// Уведомления о группе товаров
  product_group,

  /// Уведомления о оценке заказа
  rating,

  /// Уведомления о звонке
  call,

  /// Уведомления о товаре
  product;

  /// Преобразует тип уведомления в локализованную строку
  String toLocale() => switch (this) {
        NotificationsTypes.all => t.notifications.pushTypes.all,
        NotificationsTypes.orders => t.notifications.pushTypes.orders,
        NotificationsTypes.offers => t.notifications.pushTypes.stocks,
        NotificationsTypes.system => t.notifications.pushTypes.system,
        NotificationsTypes.product_group =>
          t.notifications.pushTypes.product_group,
        NotificationsTypes.rating => t.notifications.pushTypes.get_rating,
        NotificationsTypes.call => t.notifications.pushTypes.call,
        NotificationsTypes.product => t.notifications.pushTypes.product,
      };
}
