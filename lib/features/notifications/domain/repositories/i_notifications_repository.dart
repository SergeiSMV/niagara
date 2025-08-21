import '../../../../core/common/domain/models/pagination.dart';
import '../../../../core/core.dart';
import '../model/notification.dart';
import '../model/notifications_types.dart';

/// Именованный кортеж с двумя полями:
/// notifications (список уведомлений)
/// и pagination (пагинация)
///
/// [notifications] - список уведомлений
/// [pagination] - пагинация
typedef Notifications = ({
  List<NotificationItem> notifications,
  Pagination pagination
});

/// Интерфейс для работы с уведомлениями.
abstract interface class INotificationsRepository {
  /// Получает список уведомлений.
  ///
  /// - [page] - номер страницы.
  /// - [type] - тип уведомлений.
  Future<Either<Failure, Notifications>> getNotifications({
    required int page,
    required NotificationsTypes type,
  });

  /// Помечает уведомление как прочитанное.
  Future<Either<Failure, void>> readNotification({
    required String id,
  });

  /// Регистрирует токен устройства для FCM.
  Future<Either<Failure, void>> registerFcmDevice({
    required String token,
  });
}
