import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/features/auth/domain/usecases/skip_auth.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

typedef _Emit = Emitter<AuthState>;

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SkipAuthUseCase skipAuthUseCase,
  })  : _skipAuthUseCase = skipAuthUseCase,
        super(const _AuthInitialState()) {
    on<_GetCodeEvent>(_onGetCode, transformer: droppable());
    on<_AuthLaterEvent>(_onAuthLater);
  }

  final SkipAuthUseCase _skipAuthUseCase;

  void _onGetCode(_GetCodeEvent event, _Emit emit) {
    if (event.phoneNumber == null) return;
    emit(_GetCodeState(phoneNumber: event.phoneNumber!));
  }

  Future<void> _onAuthLater(_AuthLaterEvent event, _Emit emit) async {
    await _skipAuthUseCase.call();
  }
}
