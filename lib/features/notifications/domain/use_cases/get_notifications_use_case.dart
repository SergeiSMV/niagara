import '../../../../core/core.dart';
import '../model/notifications_types.dart';
import '../repositories/i_notifications_repository.dart';

/// Usecase для получения списка уведомлений
@injectable
class GetNotificationsUseCase
    extends BaseUseCase<Notifications, NotificationsParams> {
  const GetNotificationsUseCase(this._notificationsRepository);

  /// Репозиторий для работы с уведомлениями
  final INotificationsRepository _notificationsRepository;

  /// Выполняет получение списка уведомлений
  @override
  Future<Either<Failure, Notifications>> call(
    NotificationsParams params,
  ) async =>
      _notificationsRepository.getNotifications(
        page: params.page,
        type: params.type,
      );
}

/// Параметры для получения списка уведомлений
class NotificationsParams extends Equatable {
  const NotificationsParams({
    required this.page,
    required this.type,
  });

  final int page;
  final NotificationsTypes type;

  @override
  List<Object?> get props => [page, type];
}
