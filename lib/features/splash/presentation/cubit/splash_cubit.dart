import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/auth_status.dart';
import 'package:niagara_app/features/auth/domain/usecases/check_auth_status.dart';

part './splash_state.dart';
part 'splash_cubit.freezed.dart';

/// Кубит для управления состоянием загрузки приложения. Проверяет на пропуск
/// авторизации и уведомляет о завершении загрузки.
@injectable
class SplashCubit extends Cubit<SplashState> {
  /// Конструктор по умолчанию
  SplashCubit({
    required CheckAuthStatusUseCase checkAuthStatusUseCase,
    required CreateTokenUseCase getTokenUseCase,
    required CheckTokenUseCase checkTokenUseCase,
  })  : _checkAuthStatusUseCase = checkAuthStatusUseCase,
        _getTokenUseCase = getTokenUseCase,
        _checkTokenUseCase = checkTokenUseCase,
        super(const SplashState.initial());

  /// UseCase для получения токена
  final CreateTokenUseCase _getTokenUseCase;

  /// UseCase для проверки токена
  final CheckTokenUseCase _checkTokenUseCase;

  /// UseCase для проверки на пропуск авторизации
  final CheckAuthStatusUseCase _checkAuthStatusUseCase;

  /// Получение токена и проверка его валидности
  Future<void> onCheckToken() async {
    await _checkTokenUseCase.call();
    await _getTokenUseCase.call();
  }

  /// Проверка на пропуск авторизации
  Future<void> onCheckAuth() async {
    final res = await _checkAuthStatusUseCase.call().fold(
          (_) => const SplashState.error(),
          (status) => switch (status) {
            AuthenticatedStatus.unknown => const SplashState.readyToAuth(),
            _ => const SplashState.readyToMain(),
          },
        );
    emit(res);
  }
}
