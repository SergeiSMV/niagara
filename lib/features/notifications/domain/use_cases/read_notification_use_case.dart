import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/notifications/domain/repositories/notifications_repository.dart';

@injectable
class ReadNotificationUseCase extends BaseUseCase<void, String> {
  const ReadNotificationUseCase(this._notificationsRepository);

  final INotificationsRepository _notificationsRepository;

  @override
  Future<Either<Failure, void>> call(String id) async =>
      _notificationsRepository.readNotification(id: id);
}
