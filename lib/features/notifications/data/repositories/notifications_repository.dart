import 'package:niagara_app/core/common/data/mappers/pagination_mapper.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/notifications/data/mappers/notifications_mapper.dart';
import 'package:niagara_app/features/notifications/data/remote/data_source/notification_remote_data_source.dart';
import 'package:niagara_app/features/notifications/domain/model/notifications_types.dart';
import 'package:niagara_app/features/notifications/domain/repositories/notifications_repository.dart';

@LazySingleton(as: INotificationsRepository)
class NotificationsRepository extends BaseRepository
    implements INotificationsRepository {
  NotificationsRepository(
    super._logger,
    this._notificationsRDS,
  );

  final INotificationRemoteDataSource _notificationsRDS;

  @override
  Failure get failure => const NotificationsRepositoryFailure();

  @override
  Future<Either<Failure, Notifications>> getNotifications({
    required int page,
    required NotificationsTypes type,
  }) =>
      execute(() async {
        return await _notificationsRDS
            .getNotifications(page: page, type: type)
            .fold(
              (failure) => throw failure,
              (dto) => (
                notifications:
                    dto.notifications.map((e) => e.toModel()).toList(),
                pagination: dto.pagination.toModel(),
              ),
            );
      });

  @override
  Future<Either<Failure, void>> readNotification({required String id}) =>
      execute(() async {
        return await _notificationsRDS.readNotification(id: id).fold(
              (failure) => throw failure,
              (result) => result,
            );
      });
}
