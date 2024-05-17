import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/authorization/phone_auth/domain/use_cases/auth/has_auth_status_use_case.dart';
import 'package:niagara_app/features/profile/user/domain/models/user.dart';
import 'package:niagara_app/features/profile/user/domain/usecases/get_user_use_case.dart';

part 'user_event.dart';
part 'user_state.dart';
part 'user_bloc.freezed.dart';

typedef _Emit = Emitter<UserState>;

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this._hasAuthStatusUseCase, this._getUserUseCase)
      : super(const _Initial()) {
    on<_LoadingEvent>(_onStarted);

    add(const _LoadingEvent());
  }

  final HasAuthStatusUseCase _hasAuthStatusUseCase;
  final GetUserUseCase _getUserUseCase;

  Future<void> _onStarted(_LoadingEvent event, _Emit emit) async {
    emit(const _Loading());
    await _hasAuthStatusUseCase.call().fold((failure) => emit(const _Error()),
        (hasAuth) async {
      if (!hasAuth) return emit(const _Unauthorized());

      await _getUserUseCase.call().fold(
            (failure) => emit(const _Error()),
            (user) => emit(_Loaded(user)),
          );
    });
  }
}
