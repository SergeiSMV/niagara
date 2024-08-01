part of 'email_confirmation_bloc.dart';

@freezed
class EmailConfirmationState with _$EmailConfirmationState {
  const factory EmailConfirmationState.initial() = _Initial;

  const factory EmailConfirmationState.loading() = _Loading;

  const factory EmailConfirmationState.codeSent({
    required String email,
  }) = _CodeSent;

  const factory EmailConfirmationState.codeConfirmed({
    required String email,
  }) = _CodeConfirmed;

  const factory EmailConfirmationState.emailError([
    String? error,
  ]) = _EmailError;

  const factory EmailConfirmationState.codeError([
    String? error,
  ]) = _CodeError;
}
