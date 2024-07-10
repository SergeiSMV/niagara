part of 'notifications_bloc.dart';

@freezed
class NotificationsState with _$NotificationsState {
  const factory NotificationsState.loading() = _Loading;

  const factory NotificationsState.loaded({
    required List<GroupedNotifications> groupedNotifications,
    required List<NotificationItem> unreadNotifications,
    required bool isNewNotifications,
  }) = _Loaded;

  const factory NotificationsState.error() = _Error;

  const factory NotificationsState.noInternet() = _NoInternet;
}
