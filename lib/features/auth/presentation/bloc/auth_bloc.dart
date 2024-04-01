import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/features/auth/domain/usecases/skip_auth/skip_auth.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

typedef _Emit = Emitter<AuthState>;

/// [AuthBloc] - блок авторизации. Принимает [SkipAuthUseCase] для пропуска
/// авторизации. При валидации номера телефона генерирует состояния
/// [_PhoneValidState] и [_PhoneInvalidState]. При пропуске авторизации
/// генерирует состояние [_AuthLaterState].
@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// Создает объект блока авторизации.
  AuthBloc({
    required SkipAuthUseCase skipAuthUseCase,
  })  : _skipAuthUseCase = skipAuthUseCase,
        super(const _AuthInitial()) {
    on<_PhoneValidationEvent>(_onPhoneValidation);
    on<_AuthLaterEvent>(_onAuthLater);
  }
  final SkipAuthUseCase _skipAuthUseCase;

  void _onPhoneValidation(_PhoneValidationEvent event, _Emit emit) {
    final phoneNumber = event.phoneNumber?.replaceAll(RegExp(r'\D'), '');
    // Можно добавить дополнительные проверки на валидность номера
    if (phoneNumber != null && phoneNumber.length == AppConst.kPhoneDigits) {
      emit(const _PhoneValidState());
    } else {
      emit(const _PhoneInvalidState());
    }
  }

  void _onAuthLater(_AuthLaterEvent event, _Emit emit) {
    _skipAuthUseCase(const NoParams());
    emit(const _AuthLaterState());
  }
}
