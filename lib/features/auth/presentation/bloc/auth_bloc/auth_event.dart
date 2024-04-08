part of 'auth_bloc.dart';

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.getCode({
    String? phoneNumber,
  }) = _GetCodeEvent;

  const factory AuthEvent.authLater() = _AuthLaterEvent;

  const factory AuthEvent.authNow({
    required String phoneNumber,
    String? otp,
  }) = _AuthNowEvent;
}
