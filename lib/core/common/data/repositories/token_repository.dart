part of '../../../core.dart';

/// Абстракция репозитория для токена.
@LazySingleton(as: ITokenRepository)
class TokenRepository with LogMixin implements ITokenRepository {
  /// - [remoteDataSource] - удаленный источник данных для токена.
  /// - [localDataSource] - локальный источник данных для токена.
  TokenRepository({
    required ITokenRemoteDataSource remoteDataSource,
    required ITokenLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final ITokenRemoteDataSource _remoteDataSource;
  final ITokenLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, void>> onCreateToken() async {
    try {
      // Получаем идентификатор устройства
      final deviceId = await _localDataSource.onGetDeviceId();

      // Получаем токен из удаленного источника данных
      return await _remoteDataSource.onGetToken(deviceId: deviceId).fold(
        (left) => Left(logFailure(GetTokenFailure(left.error))),
        (right) async {
          // Сохраняем токен в локальном источнике данных
          await _localDataSource.onSetToken(token: right);

          // Возвращаем успешный результат
          return const Right(null);
        },
      );
    } catch (e, st) {
      // В случае ошибки возвращаем ошибку репозитория
      return Left(logError(const GetTokenFailure(), e, st));
    }
  }

  @override
  Future<Either<Failure, bool>> onCheckToken() async {
    try {
      // Получаем токен из локального источника данных
      final localToken = await _localDataSource.onGetToken();

      // Если токен пустой, возвращаем failure
      if (localToken == null || localToken.isEmpty) {
        return Left(logFailure(const CheckTokenFailure('Token is empty')));
      }

      // Проверяем токен на валидность
      return await _remoteDataSource.onCheckToken(token: localToken).fold(
        (left) => Left(logFailure(CheckTokenFailure(left.error))),
        (right) {
          // Если удаленный токен валиден, возвращаем его
          if (right.isSuccessful) return const Right(true);

          // Иначе возвращаем ошибку репозитория
          return Left(logFailure(const CheckTokenFailure('Token is invalid')));
        },
      );
    } catch (e, st) {
      // В случае ошибки возвращаем ошибку репозитория
      return Left(logError(const CheckTokenFailure(), e, st));
    }
  }

  @override
  Future<Either<Failure, String>> onGetToken() async {
    try {
      // Получаем токен из локального источника данных
      final localToken = await _localDataSource.onGetToken();

      // Если токен пустой, возвращаем failure
      if (localToken == null || localToken.isEmpty) {
        return Left(logFailure(const CheckTokenFailure('Token is empty')));
      }

      // Возвращаем токен
      return Right(localToken);
    } catch (e, st) {
      // В случае ошибки возвращаем ошибку репозитория
      return Left(logError(const CheckTokenFailure(), e, st));
    }
  }
}
