import '../../../../core/core.dart';
import 'notifications_types.dart';

class NotificationItem extends Equatable {
  const NotificationItem({
    required this.id,
    required this.date,
    required this.title,
    required this.description,
    required this.icon,
    required this.type,
    required this.link,
    required this.image,
    required this.isNew,
  });

  final String id;
  final DateTime date;
  final String title;
  final String description;
  final String icon;
  final NotificationsTypes type;
  final String link;
  final String image;
  final bool isNew;

  @override
  List<Object?> get props => [
        id,
        date,
        title,
        description,
        icon,
        type,
        link,
        image,
        isNew,
      ];
}

/// Этот класс разделитель всех уведомлений по группам по датам (по дням)
class GroupedNotifications extends Equatable {
  const GroupedNotifications({
    required this.date,
    required this.groupedNotifications,
  });

  final DateTime date;
  final List<NotificationItem> groupedNotifications;

  @override
  List<Object?> get props => [date, groupedNotifications];
}
