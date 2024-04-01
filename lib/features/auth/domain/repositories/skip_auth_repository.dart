import 'package:either_dart/either.dart';
import 'package:niagara_app/core/core.dart';

/// Абстракция репозитория для пропуска авторизации.
abstract interface class ISkipAuthRepository {
  /// Метод [skipAuth] выполняет пропуск авторизации.
  Future<Either<Failure, void>> skipAuth({required bool skipAuth});

  /// Метод [checkSkipAuth] проверяет пропущена ли авторизация.
  Future<Either<Failure, bool>> checkSkipAuth();
}
