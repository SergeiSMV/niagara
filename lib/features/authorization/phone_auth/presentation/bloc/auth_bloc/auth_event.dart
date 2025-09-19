part of 'auth_bloc.dart';

/// События блока авторизации
@freezed
sealed class AuthEvent with _$AuthEvent {
  /// Событие получения кода
  const factory AuthEvent.getCode({
    required String phoneNumber,
  }) = _GetCodeEvent;

  /// Событие переотправки кода
  const factory AuthEvent.resendCode() = _ResendCodeEvent;

  /// Событие изменения OTP кода
  const factory AuthEvent.otpChanged() = _OtpChangedEvent;

  /// Событие пропуска авторизации
  const factory AuthEvent.authLater() = _AuthLaterEvent;

  /// Событие авторизации
  const factory AuthEvent.authNow({
    required String otp,
    required bool user,
    required bool marketing,
  }) = _AuthNowEvent;
}
