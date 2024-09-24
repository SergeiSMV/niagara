import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/notifications/domain/model/notifications_types.dart';
import 'package:niagara_app/features/notifications/domain/repositories/notifications_repository.dart';

@injectable
class GetNotificationsUseCase
    extends BaseUseCase<Notifications, NotificationsParams> {
  const GetNotificationsUseCase(this._notificationsRepository);

  final INotificationsRepository _notificationsRepository;

  @override
  Future<Either<Failure, Notifications>> call(
    NotificationsParams params,
  ) async =>
      _notificationsRepository.getNotifications(
        page: params.page,
        type: params.type,
      );
}

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
