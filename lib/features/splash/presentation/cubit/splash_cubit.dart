import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/utils/enums/auth_status.dart';
import 'package:niagara_app/features/auth/domain/usecases/check_auth_status.dart';

part './splash_state.dart';
part 'splash_cubit.freezed.dart';

/// Кубит для управления состоянием загрузки приложения. Проверяет на пропуск
/// авторизации и уведомляет о завершении загрузки.
@lazySingleton
class SplashCubit extends Cubit<SplashState> {
  SplashCubit({
    required CheckAuthStatusUseCase checkAuthStatusUseCase,
  })  : _checkAuthStatusUseCase = checkAuthStatusUseCase,
        super(const SplashState.initial());

  final CheckAuthStatusUseCase _checkAuthStatusUseCase;

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
