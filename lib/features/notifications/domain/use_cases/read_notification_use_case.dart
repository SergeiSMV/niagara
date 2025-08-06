import '../../../../core/core.dart';
import '../repositories/i_notifications_repository.dart';

/// Usecase для помечания уведомления как прочитанного
@injectable
class ReadNotificationUseCase extends BaseUseCase<void, String> {
  const ReadNotificationUseCase(this._notificationsRepository);

  /// Репозиторий для работы с уведомлениями
  final INotificationsRepository _notificationsRepository;

  /// Выполняет помечание уведомления как прочитанного
  @override
  Future<Either<Failure, void>> call(String id) async =>
      _notificationsRepository.readNotification(id: id);
}
