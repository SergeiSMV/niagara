import 'package:either_dart/either.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/auth_status.dart';

/// Абстракция репозитория для пропуска авторизации.
abstract interface class IAuthRepository {
  /// Метод [onSetAuthStatus] выполняет пропуск авторизации.
  Future<Either<Failure, void>> onSetAuthStatus({
    required AuthenticatedStatus status,
  });

  /// Метод [onCheckAuthStatus] проверяет авторизацию.
  Future<Either<Failure, AuthenticatedStatus>> onCheckAuthStatus();
}
