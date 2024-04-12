part of 'auth_bloc.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = _AuthInitialState;

  const factory AuthState.loading() = _AuthLoadingState;

  const factory AuthState.getCode({
    required String phoneNumber,
  }) = _GetCodeState;

  const factory AuthState.getCodeError([
    String? failure,
  ]) = _GetCodeErrorState;

  const factory AuthState.otpWaiting() = _OtpWaitingState;

  const factory AuthState.otpSuccess() = _OtpSuccessState;

  const factory AuthState.otpError([
    String? failure,
  ]) = _OtpErrorState;

  const factory AuthState.authLater() = _AuthLaterState;
}
