part of 'notifications_bloc.dart';

@freezed
class NotificationsEvent with _$NotificationsEvent {
  const factory NotificationsEvent.loading({
    required bool isForceUpdate,
  }) = _LoadingEvent;

  const factory NotificationsEvent.openedFromPush() = _OpenedFromPushEvent;

  const factory NotificationsEvent.openedProductFromPush() =
      _OpenedProductFromPushEvent;
  const factory NotificationsEvent.openedProductGroupFromPush() =
      _OpenedProductGroupFromPushEvent;

  const factory NotificationsEvent.loadMore() = _LoadMoreEvent;

  const factory NotificationsEvent.setSort({
    required NotificationsTypes sort,
  }) = _SetSortEvent;
}
