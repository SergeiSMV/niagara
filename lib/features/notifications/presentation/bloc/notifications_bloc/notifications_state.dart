part of 'notifications_bloc.dart';

/// Состояние блока уведомлений
@freezed
class NotificationsState with _$NotificationsState {
  const factory NotificationsState.loading() = _Loading;

  /// Уведомление открыто из Push без типа
  const factory NotificationsState.openedFromPush() = _OpenedFromPush;

  /// Уведомление открыто из Push с типом "PRODUCT"
  const factory NotificationsState.openedProductFromPush({
    required Product? product,
  }) = _OpenedProductFromPush;

  /// Уведомление открыто из Push с типом "GROUP"
  const factory NotificationsState.openedProductGroupFromPush({
    required String groupId,
  }) = _OpenedProductGroupFromPush;

  /// Уведомление открыто из Push с типом "GET_RATING"
  const factory NotificationsState.openedGetRatingFromPush({
    required UserOrder? order,
  }) = _OpenedGetRatingFromPush;

  /// Уведомление открыто из Push с типом "CALL"
  const factory NotificationsState.openedCallFromPush({
    required String phoneNumber,
  }) = _OpenedCallFromPush;

  const factory NotificationsState.loaded({
    required List<GroupedNotifications> groupedNotifications,
    required List<NotificationItem> unreadNotifications,
    required bool isNewNotifications,
  }) = _Loaded;

  const factory NotificationsState.error() = _Error;

  const factory NotificationsState.noInternet() = _NoInternet;
}
