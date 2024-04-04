part of '../../../core.dart';

/// Интерфейс репозитория для работы с токеном доступа
abstract interface class ITokenRepository {
  /// Получить токен
  Future<Either<Failure, void>> getToken();

  /// Проверить токен
  Future<Either<Failure, String?>> checkToken();
}
