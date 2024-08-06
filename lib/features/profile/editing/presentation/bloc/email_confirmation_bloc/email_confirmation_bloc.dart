import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/editing/domain/use_cases/check_email_code_use_case.dart';
import 'package:niagara_app/features/profile/editing/domain/use_cases/send_email_code_use_case.dart';

part 'email_confirmation_state.dart';
part 'email_confirmation_event.dart';
part 'email_confirmation_bloc.freezed.dart';

typedef _Emit = Emitter<EmailConfirmationState>;

@injectable
class EmailConfirmationBloc
    extends Bloc<EmailConfirmationEvent, EmailConfirmationState> {
  EmailConfirmationBloc(
    this._sendCodeUseCase,
    this._checkCodeUseCase,
  ) : super(const EmailConfirmationState.initial()) {
    on<_CreateEmailCodeEvent>(_onCreateCode);
    on<_ConfirmEmailCodeEvent>(_onConfirmCode);
    on<_ResendEmailCodeEvent>(_onResendCode);
  }

  final SendEmailCodeUseCase _sendCodeUseCase;
  final CheckEmailCodeUseCase _checkCodeUseCase;

  String? _email;

  Future<void> _onCreateCode(_CreateEmailCodeEvent event, _Emit emit) async {
    emit(const _Loading());

    final String email = event.email;
    _email = email;

    await _sendCodeUseCase.call(SendEmailCodeParams(email: email)).fold(
          (failure) => emit(_EmailError(failure.error)),
          (_) => emit(_CodeSent(email: email)),
        );
  }

  Future<void> _onConfirmCode(_ConfirmEmailCodeEvent event, _Emit emit) async {
    emit(const _Loading());

    final String code = event.code;
    await _checkCodeUseCase.call(CheckEmailCodeParams(code: code)).fold(
          (failure) => emit(_CodeError(failure.error)),
          (_) => emit(_CodeConfirmed(email: _email!)),
        );
  }

  Future<void> _onResendCode(_ResendEmailCodeEvent event, _Emit emit) async {
    if (_email == null) {
      return emit(const _ResendError());
    }

    emit(const _Loading());

    await _sendCodeUseCase.call(SendEmailCodeParams(email: _email!)).fold(
          (failure) => emit(_ResendError(failure.error)),
          (_) => emit(_CodeSent(email: _email!)),
        );
  }
}
