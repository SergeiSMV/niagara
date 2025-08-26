import 'dart:async';

import '../../../../core/common/data/mappers/pagination_mapper.dart';
import '../../../../core/core.dart';
import '../../domain/model/notifications_types.dart';
import '../../domain/repositories/i_notifications_repository.dart';
import '../mappers/notifications_mapper.dart';
import '../remote/data_source/notification_remote_data_source.dart';

/// Репозиторий для работы с уведомлениями
@LazySingleton(as: INotificationsRepository)
class NotificationsRepository extends BaseRepository
    implements INotificationsRepository {
  NotificationsRepository(
    super._logger,
    super._networkInfo,
    this._notificationsRDS,
  );

  /// Источник данных для уведомлений
  final INotificationRemoteDataSource _notificationsRDS;

  /// Ошибка репозитория
  @override
  Failure get failure => const NotificationsRepositoryFailure();

  /// Получает список уведомлений
  @override
  Future<Either<Failure, Notifications>> getNotifications({
    required int page,
    required NotificationsTypes type,
  }) =>
      execute(
        () async => await _notificationsRDS
            .getNotifications(page: page, type: type)
            .fold(
              (failure) => throw failure,
              (dto) => (
                notifications:
                    dto.notifications.map((e) => e.toModel()).toList(),
                pagination: dto.pagination.toModel(),
              ),
            ),
      );

  /// Помечает уведомление как прочитанное
  @override
  Future<Either<Failure, void>> readNotification({required String id}) =>
      execute(
        () async => await _notificationsRDS.readNotification(id: id).fold(
              (failure) => throw failure,
              (result) => result,
            ),
      );

  /// Отправляет на бекенд FCM-токен устройства
  @override
  Future<Either<Failure, void>> registerFcmDevice({
    required String token,
  }) =>
      execute(() async {
        // await Jivo.notifications.setPushToken(token);
        await _notificationsRDS.registerFcmDevice(token).fold(
              (failure) => throw failure,
              (result) => result,
            );
      });
}
