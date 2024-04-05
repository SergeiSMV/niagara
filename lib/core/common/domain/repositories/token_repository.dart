part of '../../../core.dart';

/// Интерфейс репозитория для работы с токеном доступа
abstract interface class ITokenRepository {
  /// Создать токен
  Future<Either<Failure, void>> onCreateToken();

  /// Проверить токен
  Future<Either<Failure, bool>> onCheckToken();

  /// Получить токен
  Future<Either<Failure, String>> onGetToken();
}
