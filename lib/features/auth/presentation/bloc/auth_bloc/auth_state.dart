part of 'auth_bloc.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = _AuthInitialState;

  const factory AuthState.getCode({
    required String phoneNumber,
  }) = _GetCodeState;

  const factory AuthState.authLater() = _AuthLaterState;
}
