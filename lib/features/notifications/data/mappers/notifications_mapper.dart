import 'package:niagara_app/features/notifications/data/remote/dto/notification_dto.dart';
import 'package:niagara_app/features/notifications/domain/model/notification.dart';
import 'package:niagara_app/features/notifications/domain/model/notifications_types.dart';

extension NotificationDtoMapper on NotificationDto {
  NotificationItem toModel() {
    return NotificationItem(
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
}
