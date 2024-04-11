import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/features/auth/domain/usecases/check_otp_code.dart';
import 'package:niagara_app/features/auth/domain/usecases/resend_code.dart';
import 'package:niagara_app/features/auth/domain/usecases/send_code.dart';
import 'package:niagara_app/features/auth/domain/usecases/skip_auth.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

typedef _Emit = Emitter<AuthState>;

/// Блок для авторизации. Отправляет код на телефон, проверяет его и пропускает
/// авторизацию. При ошибке отправки кода, проверки кода или пропуска
/// авторизации отправляет ошибку.
@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SkipAuthUseCase skipAuthUseCase,
    required SendPhoneUseCase sendPhoneUseCase,
    required ResendPhoneUseCase resendPhoneUseCase,
    required CheckOTPCodeUseCase checkOTPCodeUseCase,
  })  : _skipAuthUseCase = skipAuthUseCase,
        _sendPhoneUseCase = sendPhoneUseCase,
        _resendPhoneUseCase = resendPhoneUseCase,
        _checkOTPCodeUseCase = checkOTPCodeUseCase,
        super(const _AuthInitialState()) {
    on<_GetCodeEvent>(_onGetCode, transformer: droppable());
    on<_ResendCodeEvent>(_onResendCode, transformer: droppable());
    on<_OtpChangedEvent>(_onOtpChanged);
    on<_AuthNowEvent>(_onAuthNow);
    on<_AuthLaterEvent>(_onAuthLater);
  }

  final SkipAuthUseCase _skipAuthUseCase;
  final SendPhoneUseCase _sendPhoneUseCase;
  final ResendPhoneUseCase _resendPhoneUseCase;
  final CheckOTPCodeUseCase _checkOTPCodeUseCase;

  Future<void> _onGetCode(_GetCodeEvent event, _Emit emit) async {
    emit(const _AuthLoadingState());
    final phoneNumber = event.phoneNumber;
    await _sendPhoneUseCase.call(SendPhoneParams(phone: phoneNumber)).fold(
      (failure) => emit(_GetCodeErrorState(failure.error)),
      (_) {
        emit(_GetCodeState(phoneNumber: event.phoneNumber));
        emit(const _OtpWaitingState());
      },
    );
  }

  Future<void> _onResendCode(_ResendCodeEvent event, _Emit emit) async {
    emit(const _AuthLoadingState());
    await _resendPhoneUseCase.call().fold(
          (failure) => emit(_GetCodeErrorState(failure.error)),
          (_) => emit(const _OtpWaitingState()),
        );
  }

  void _onOtpChanged(_OtpChangedEvent event, _Emit emit) {
    if (state is _OtpErrorState) emit(const _OtpWaitingState());
  }

  Future<void> _onAuthNow(_AuthNowEvent event, _Emit emit) async {
    emit(const _AuthLoadingState());
    await _checkOTPCodeUseCase.call(CheckOTPParams(code: event.otp)).fold(
          (failure) => emit(_OtpErrorState(failure.error)),
          (_) => emit(const _OtpSuccessState()),
        );
  }

  Future<void> _onAuthLater(_AuthLaterEvent event, _Emit emit) async {
    await _skipAuthUseCase.call();
  }
}
