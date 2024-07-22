part of 'user_bloc.dart';

@freezed
class UserEvent with _$UserEvent {
  const factory UserEvent.loading() = _LoadingEvent;
  const factory UserEvent.logout() = _LogoutEvent;
  const factory UserEvent.deleteAccount() = _DeleteAccountEvent;
}
