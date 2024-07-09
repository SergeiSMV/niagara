import 'package:niagara_app/core/common/domain/models/pagination.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/notifications/domain/model/notification.dart';
import 'package:niagara_app/features/notifications/domain/model/notifications_types.dart';

typedef Notifications = ({
  List<NotificationItem> notifications,
  Pagination pagination
});

abstract interface class INotificationsRepository {
  Future<Either<Failure, Notifications>> getNotifications({
    required int page,
    required NotificationsTypes type,
  });

  Future<Either<Failure, void>> readNotification({
    required String id,
  });
}
