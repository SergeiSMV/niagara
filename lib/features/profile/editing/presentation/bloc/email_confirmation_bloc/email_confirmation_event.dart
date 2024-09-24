part of 'email_confirmation_bloc.dart';

@freezed
class EmailConfirmationEvent with _$EmailConfirmationEvent {
  const factory EmailConfirmationEvent.createCode({
    required String email,
  }) = _CreateEmailCodeEvent;

  const factory EmailConfirmationEvent.confirmCode({
    required String code,
  }) = _ConfirmEmailCodeEvent;

  const factory EmailConfirmationEvent.resendCode() = _ResendEmailCodeEvent;
}
