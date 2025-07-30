import '../../../../core/common/domain/models/pagination.dart';
import '../../../../core/core.dart';
import '../model/notification.dart';
import '../model/notifications_types.dart';

typedef Notifications = ({
  List<NotificationItem> notifications,
  Pagination pagination
});

/// Репозиторий для работы с уведомлениями.
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

  /// Закрывает подписки.
  void dispose();

  /// Инициализация репозитория.
  void init();
}
