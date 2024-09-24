part of 'email_confirmation_bloc.dart';

@freezed
class EmailConfirmationState with _$EmailConfirmationState {
  /// Начальное состояние.
  ///
  /// Отображается форма для ввода email.
  const factory EmailConfirmationState.initial() = _Initial;

  /// Состояние загрузки после отправки кода подтверждения или при ожидании
  /// валидации кода.
  const factory EmailConfirmationState.loading() = _Loading;

  /// Ожидание ввода кода подтверждения.
  const factory EmailConfirmationState.codeSent({
    required String email,
  }) = _CodeSent;

  /// Состояние после успешного подтверждения кода.
  const factory EmailConfirmationState.codeConfirmed({
    required String email,
  }) = _CodeConfirmed;

  /// Состояние ошибки при отправке email.
  const factory EmailConfirmationState.emailError([
    String? error,
  ]) = _EmailError;

  /// Состояние ошибки при отправке кода.
  const factory EmailConfirmationState.codeError([
    String? error,
  ]) = _CodeError;

  /// Состояние ошибки при повторной отправке кода.
  const factory EmailConfirmationState.resendCodeError([
    String? error,
  ]) = _ResendError;
}
