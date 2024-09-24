part of 'auth_bloc.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;

  const factory AuthState.loading() = _Loading;

  const factory AuthState.getCode({required String phoneNumber}) = _GetCode;

  const factory AuthState.getCodeError([String? failure]) = _GetCodeError;

  const factory AuthState.otpWaiting() = _OtpWaiting;

  const factory AuthState.otpSuccess() = _OtpSuccess;

  const factory AuthState.otpError() = _OtpError;

  const factory AuthState.otpChangeError() = _OtpChangeError;

  const factory AuthState.authLater() = _AuthLater;
}
