part of 'auth_bloc.dart';

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.getCode({
    required String phoneNumber,
  }) = _GetCodeEvent;

  const factory AuthEvent.resendCode() = _ResendCodeEvent;

  const factory AuthEvent.otpChanged() = _OtpChangedEvent;

  const factory AuthEvent.authLater() = _AuthLaterEvent;

  const factory AuthEvent.authNow({
    required String otp,
  }) = _AuthNowEvent;
}
