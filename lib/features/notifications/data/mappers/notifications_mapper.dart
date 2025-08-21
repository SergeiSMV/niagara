import '../../domain/model/notification.dart';
import '../../domain/model/notifications_types.dart';
import '../remote/dto/notification_dto.dart';

extension NotificationDtoMapper on NotificationDto {
  NotificationItem toModel() => NotificationItem(
        id: id,
        date: date,
        title: title,
        description: description,
        icon: icon,
        type: NotificationsTypes.values.byName(type.toLowerCase()),
        link: link,
        image: image,
        isNew: isNew,
      );
}
