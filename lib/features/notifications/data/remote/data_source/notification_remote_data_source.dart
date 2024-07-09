import 'package:niagara_app/core/common/data/remote/dto/pagination_dto.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/notifications/data/remote/dto/notification_dto.dart';
import 'package:niagara_app/features/notifications/domain/model/notifications_types.dart';

abstract interface class INotificationRemoteDataSource {
  Future<Either<Failure, NotificationsDto>> getNotifications({
    required int page,
    required NotificationsTypes type,
  });

  Future<Either<Failure, bool>> readNotification({
    required String id,
  });
}

@LazySingleton(as: INotificationRemoteDataSource)
class NotificationRemoteDataSource implements INotificationRemoteDataSource {
  NotificationRemoteDataSource(this._requestHandler);

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, NotificationsDto>> getNotifications({
    required int page,
    required NotificationsTypes type,
  }) =>
      _requestHandler.sendRequest<NotificationsDto, Map<String, dynamic>>(
        request: (Dio dio) => dio.get(
          ApiConst.kGetNotifications,
          queryParameters: {
            if (type != NotificationsTypes.all) 'type': type.name.toUpperCase(),
            'page': page,
          },
        ),
        converter: (json) {
          final notifications = (json['data'] as List<dynamic>)
              .map((e) => NotificationDto.fromJson(e as Map<String, dynamic>))
              .toList();

          final pagination = PaginationDto.fromJson(
            json['pagination'] as Map<String, dynamic>,
          );

          return (notifications: notifications, pagination: pagination);
        },
        failure: NotificationsRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, bool>> readNotification({required String id}) =>
      _requestHandler.sendRequest<bool, Map<String, dynamic>>(
        request: (Dio dio) => dio.post(
          ApiConst.kReadNotifications,
          data: {
            'ID': id,
          },
        ),
        converter: (json) => json['response'] as bool,
        failure: NotificationsRemoteDataFailure.new,
      );
}
