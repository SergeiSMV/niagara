part of 'auth_bloc.dart';

/// [AuthEvent] - события блока авторизации.
@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.getCode(
    String? phoneNumber,
  ) = _GetCodeEvent;

  const factory AuthEvent.resendCode() = _ResendCodeEvent;

  const factory AuthEvent.authLater() = _AuthLaterEvent;
}
