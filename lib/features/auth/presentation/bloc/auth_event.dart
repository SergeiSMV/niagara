part of 'auth_bloc.dart';

/// [AuthEvent] - события блока авторизации. При валидации номера телефона
/// генерирует событие [_PhoneValidationEvent]. При запросе кода генерирует
/// событие [_GetCodeEvent]. При пропуске авторизации генерирует событие
/// [_AuthLaterEvent].
@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.phoneValidation(String? phoneNumber) =
      _PhoneValidationEvent;
  const factory AuthEvent.getCode(String? phoneNumber) = _GetCodeEvent;
  const factory AuthEvent.authLater() = _AuthLaterEvent;
}
