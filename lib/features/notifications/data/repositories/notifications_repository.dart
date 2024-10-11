import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
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
    super._networkInfo,
    this._notificationsRDS,
    this._fcmInstance,
  ) {
    init();
  }

  final INotificationRemoteDataSource _notificationsRDS;
  final FirebaseMessaging _fcmInstance;

  @override
  Future<void> init() async {
    _onTokenRefresh = _fcmInstance.onTokenRefresh.listen(_registerFcmDevice);

    final String? fcmToken = await _fcmInstance.getToken();
    if (fcmToken != null) {
      await _registerFcmDevice(fcmToken);
    }
  }

  @override
  @disposeMethod
  void dispose() {
    _onTokenRefresh?.cancel();
  }

  /// Подписка на обновление FCM токена.
  ///
  /// Посылает на бекенд новый токен.
  StreamSubscription? _onTokenRefresh;

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

  /// Отправляет на бекенд FCM-токен устройства.
  Future<Either<Failure, void>> _registerFcmDevice(String fcmToken) => execute(
        () => _notificationsRDS.registerFcmDevice(fcmToken).fold(
              (failure) => throw failure,
              (result) => result,
            ),
      );
}
