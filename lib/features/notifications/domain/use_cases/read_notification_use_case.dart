import '../../../../core/core.dart';
import '../repositories/notifications_repository.dart';

@injectable
class ReadNotificationUseCase extends BaseUseCase<void, String> {
  const ReadNotificationUseCase(this._notificationsRepository);

  final INotificationsRepository _notificationsRepository;

  @override
  Future<Either<Failure, void>> call(String id) async =>
      _notificationsRepository.readNotification(id: id);
}
