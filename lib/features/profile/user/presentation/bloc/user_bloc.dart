import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/authorization/phone_auth/domain/use_cases/auth/has_auth_status_use_case.dart';
import 'package:niagara_app/features/authorization/phone_auth/domain/use_cases/auth/logout_use_case.dart';
import 'package:niagara_app/features/profile/user/domain/models/user.dart';
import 'package:niagara_app/features/profile/user/domain/usecases/delete_user_use_case.dart';
import 'package:niagara_app/features/profile/user/domain/usecases/get_user_use_case.dart';
import 'package:niagara_app/features/profile/user/domain/usecases/update_user_use_case.dart';

part 'user_event.dart';
part 'user_state.dart';
part 'user_bloc.freezed.dart';

typedef _Emit = Emitter<UserState>;

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(
    this._hasAuthStatusUseCase,
    this._getUserUseCase,
    this._logoutUseCase,
    this._deleteUserUseCase,
    this._updateUserUseCase,
  ) : super(const _Initial()) {
    on<_LoadingEvent>(_onStarted);
    on<_LogoutEvent>(_onLogout);
    on<_DeleteAccountEvent>(_onDeleteAccount);
    on<_UpdateUserEvent>(_onUpdateUser);

    add(const _LoadingEvent());
  }

  final HasAuthStatusUseCase _hasAuthStatusUseCase;
  final GetUserUseCase _getUserUseCase;
  final LogoutUseCase _logoutUseCase;
  final DeleteUserUseCase _deleteUserUseCase;
  final UpdateUserUseCase _updateUserUseCase;

  bool get isAuthorized => state is! _Unauthorized;

  Future<void> _onStarted(_LoadingEvent event, _Emit emit) async {
    emit(const _Loading());

    await _hasAuthStatusUseCase.call().fold(
      (failure) => emit(const _Error()),
      (hasAuth) async {
        if (!hasAuth) return emit(const _Unauthorized());

        await _getUserUseCase.call().fold(
              (failure) => emit(const _Error()),
              (user) => emit(_Loaded(user)),
            );
      },
    );
  }

  Future<void> _onLogout(_LogoutEvent event, _Emit emit) async {
    if (state is! _Loaded) return;

    await _logoutUseCase.call((state as _Loaded).user).fold(
          (failure) => emit(const _Error()),
          (_) => emit(const _Unauthorized(loggedOut: true)),
        );
  }

  Future<void> _onDeleteAccount(_DeleteAccountEvent event, _Emit emit) async {
    if (state is! _Loaded) return;

    await _deleteUserUseCase.call((state as _Loaded).user).fold(
          (failure) => emit(const _Error()),
          (_) => emit(const _Unauthorized(loggedOut: true)),
        );
  }

  Future<void> _onUpdateUser(_UpdateUserEvent event, _Emit emit) async {
    if (state is! _Loaded) return;
    emit(const _Loading());

    try {
      await _updateUserUseCase.call(event.user).fold(
            (failure) => emit(const _Error()),
            (_) => emit(_Loaded(event.user)),
          );
    } on Object {
      emit(_Loaded(event.user));
    }
  }
}
