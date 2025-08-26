import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/core.dart';
import '../../../../../core/utils/enums/auth_status.dart';
import '../../../../../core/utils/services/userx_service/userx_service.dart';
import '../../../../authorization/phone_auth/domain/use_cases/auth/has_auth_status_use_case.dart';
import '../../../../authorization/phone_auth/domain/use_cases/auth/logout_use_case.dart';
import '../../domain/models/user.dart';
import '../../domain/usecases/delete_user_use_case.dart';
import '../../domain/usecases/get_user_use_case.dart';
import '../../domain/usecases/update_user_use_case.dart';

part 'user_bloc.freezed.dart';
part 'user_event.dart';
part 'user_state.dart';

typedef _Emit = Emitter<UserState>;

@lazySingleton
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(
    this._hasAuthStatusUseCase,
    this._getUserUseCase,
    this._logoutUseCase,
    this._deleteUserUseCase,
    this._updateUserUseCase,
    this._authStatusStream,
    this._uxCamService,
  ) : super(const _Initial()) {
    _authStatusSubscription = _authStatusStream.listen(_onAuthStatusChanged);

    on<_LoadingEvent>(_onStarted);
    on<_LogoutEvent>(_onLogout);
    on<_DeleteAccountEvent>(_onDeleteAccount);
    on<_UpdateUserEvent>(_onUpdateUser);

    add(const _LoadingEvent());
  }

  /// Кейс проверки статуса авторизации
  final HasAuthStatusUseCase _hasAuthStatusUseCase;

  /// Кейс получения данных пользователя
  final GetUserUseCase _getUserUseCase;

  /// Кейс выхода из аккаунта
  final LogoutUseCase _logoutUseCase;

  /// Кейс удаления аккаунта
  final DeleteUserUseCase _deleteUserUseCase;

  /// Кейс обновления данных пользователя
  final UpdateUserUseCase _updateUserUseCase;

  /// Поток статуса авторизации
  final Stream<AuthenticatedStatus> _authStatusStream;

  /// Сервис для работы с UserX
  final UserXService _uxCamService;

  /// Подписка на изменение статуса авторизации.
  StreamSubscription? _authStatusSubscription;

  /// Флаг для установки идентификатора пользователя в UserX
  bool _setUserIdentity = true;

  /// Проверяет, авторизован ли пользователь.
  Future<bool?> get isAuthorized => _hasAuthStatusUseCase().fold(
        (failure) => null,
        (hasAuth) => hasAuth,
      );

  /// Когда изменяется состояние авторизации, происходит новый запрос корзины.
  void _onAuthStatusChanged(AuthenticatedStatus status) =>
      add(const _LoadingEvent());

  /// Загружает данные пользователя
  Future<void> _onStarted(_LoadingEvent event, _Emit emit) async {
    emit(const _Loading());

    final bool? hasAuth = await isAuthorized;
    if (hasAuth == null) {
      return emit(const _Error());
    } else if (!hasAuth) {
      return emit(const _Unauthorized());
    }

    await _getUserUseCase.call().fold(
      (failure) => emit(const _Error()),
      (user) async {
        if (_setUserIdentity) {
          await _uxCamService.setUserIdentity(user.phone);
        }
        emit(_Loaded(user));
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

  /// Устанавливает флаг для установки идентификатора пользователя в UserX
  void setUserIdentity(bool value) => _setUserIdentity = value;

  @override
  Future<void> close() async {
    await _authStatusSubscription?.cancel();
    return super.close();
  }
}
