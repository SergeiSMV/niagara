import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/utils/enums/auth_status.dart';
import 'package:niagara_app/features/auth/domain/usecases/set_auth_status.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

typedef _Emit = Emitter<AuthState>;

/// [AuthBloc] - блок авторизации. Отвечает за авторизацию пользователя.
/// При успешной авторизации переходит на главный экран, а так же можно
/// продолжить работу без авторизации.
@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// Создает объект блока авторизации.
  AuthBloc({
    required SetAuthStatusUseCase setAuthStatusUseCase,
  })  : _setAuthStatusUseCase = setAuthStatusUseCase,
        super(const _AuthInitialState()) {
    on<_GetCodeEvent>(_onGetCode, transformer: droppable());
    on<_AuthLaterEvent>(_onAuthLater);
  }

  // Используемые кейсы:
  final SetAuthStatusUseCase _setAuthStatusUseCase;

  void _onGetCode(_GetCodeEvent event, _Emit emit) {
    if (event.phoneNumber == null) return;
    emit(_GetCodeState(phoneNumber: event.phoneNumber!));
  }

  Future<void> _onAuthLater(_AuthLaterEvent event, _Emit emit) async {
    await _setAuthStatusUseCase.call(
      SetAuthStatusParams(
        status: AuthenticatedStatus.unauthenticated,
      ),
    );
  }
}
