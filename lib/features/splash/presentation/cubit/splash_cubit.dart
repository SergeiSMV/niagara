import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/auth/domain/usecases/skip_auth/check_skip_auth.dart';

part 'splash_cubit.freezed.dart';
part './splash_state.dart';

/// Кубит для управления состоянием загрузки приложения. Проверяет на пропуск
/// авторизации и уведомляет о завершении загрузки.
@injectable
class SplashCubit extends Cubit<SplashState> {
  /// Конструктор по умолчанию
  SplashCubit({
    required CheckSkipAuthUseCase checkSkipAuthUseCase,
  })  : _checkSkipAuthUseCase = checkSkipAuthUseCase,
        super(const SplashState.initial());

  /// UseCase для проверки на пропуск авторизации
  final CheckSkipAuthUseCase _checkSkipAuthUseCase;

  /// Проверка на пропуск авторизации
  Future<void> onCheckAuth() =>
      _checkSkipAuthUseCase.call(const NoParams()).fold(
            (_) => emit(const SplashState.error()),
            (skipAuth) => skipAuth ? onWaiting() : onDone(),
          );

  /// Уведомление о загрузке данных (для загрузки главной)
  void onWaiting() => emit(const SplashState.waiting());

  /// Завершение splash-экрана
  void onDone() => emit(const SplashState.done());
}
