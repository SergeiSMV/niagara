import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/auth/domain/usecases/skip_auth/skip_auth.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

typedef _Emit = Emitter<AuthState>;

/// [AuthBloc] - блок авторизации. Принимает [SkipAuthUseCase] для пропуска
/// авторизации. При пропуске авторизации
/// генерирует состояние [_AuthLaterState].
@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// Создает объект блока авторизации.
  AuthBloc({
    required SkipAuthUseCase skipAuthUseCase,
  })  : _skipAuthUseCase = skipAuthUseCase,
        super(const _AuthInitialState()) {
    on<_GetCodeEvent>(_onGetCode, transformer: droppable());
    on<_AuthLaterEvent>(_onAuthLater);
  }

  // Используемые кейсы:
  final SkipAuthUseCase _skipAuthUseCase;

  void _onGetCode(_GetCodeEvent event, _Emit emit) {
    if (event.phoneNumber == null) return;
    emit(const _AuthInitialState());
    emit(_GetCodeState(phoneNumber: event.phoneNumber!));
  }

  void _onAuthLater(_AuthLaterEvent event, _Emit emit) {
    _skipAuthUseCase.call(const NoParams());
    emit(const _AuthLaterState());
  }
}
