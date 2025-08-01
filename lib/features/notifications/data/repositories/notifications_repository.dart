import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../../core/common/data/mappers/pagination_mapper.dart';
import '../../../../core/core.dart';
import '../../domain/model/notifications_types.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../mappers/notifications_mapper.dart';
import '../remote/data_source/notification_remote_data_source.dart';

@LazySingleton(as: INotificationsRepository)
class NotificationsRepository extends BaseRepository
    implements INotificationsRepository {
  NotificationsRepository(
    super._logger,
    super._networkInfo,
    this._notificationsRDS,
    this._fcmInstance,
  ) {
    unawaited(init());
  }

  final INotificationRemoteDataSource _notificationsRDS;
  final FirebaseMessaging _fcmInstance;

  @override
  Future<void> init() async {
    await execute(() async {
      final String? fcmToken = await _fcmInstance.getToken();

      if (fcmToken != null) {
        // Регистрация токена на бекенде
        await _registerFcmDevice(fcmToken);
      }

      _onTokenRefresh = _fcmInstance.onTokenRefresh.listen(_registerFcmDevice);
    });
  }

  @override
  @disposeMethod
  Future<void> dispose() async {
    await _onTokenRefresh?.cancel();
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
      execute(() async => await _notificationsRDS
          .getNotifications(page: page, type: type)
          .fold(
            (failure) => throw failure,
            (dto) => (
              notifications: dto.notifications.map((e) => e.toModel()).toList(),
              pagination: dto.pagination.toModel(),
            ),
          ));

  @override
  Future<Either<Failure, void>> readNotification({required String id}) =>
      execute(
        () async => await _notificationsRDS.readNotification(id: id).fold(
              (failure) => throw failure,
              (result) => result,
            ),
      );

  /// Отправляет на бекенд FCM-токен устройства.
  Future<Either<Failure, void>> _registerFcmDevice(String fcmToken) =>
      execute(() async {
        // await Jivo.notifications.setPushToken(fcmToken);
        await _notificationsRDS.registerFcmDevice(fcmToken).fold(
              (failure) => throw failure,
              (result) => result,
            );
      });
}
