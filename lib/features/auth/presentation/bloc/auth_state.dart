part of 'auth_bloc.dart';

/// [AuthState] - состояния блока авторизации. При валидации номера телефона
/// генерирует состояния [_PhoneValidState] и [_PhoneInvalidState]. При пропуске
/// авторизации генерирует состояние [_AuthLaterState].
@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = _AuthInitial;

  const factory AuthState.phoneValid() = _PhoneValidState;
  const factory AuthState.phoneInvalid() = _PhoneInvalidState;

  const factory AuthState.authLater() = _AuthLaterState;
}
