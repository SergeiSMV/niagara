part of '../../../core.dart';

/// Абстракция репозитория для токена.
@LazySingleton(as: ITokenRepository)
class TokenRepository implements ITokenRepository {
  /// - [remoteDataSource] - удаленный источник данных для токена.
  /// - [localDataSource] - локальный источник данных для токена.
  TokenRepository({
    required ITokenRemoteDataSource remoteDataSource,
    required ITokenLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final ITokenRemoteDataSource _remoteDataSource;
  final ITokenLocalDataSource _localDataSource;

  /// Возвращает ошибку репозитория с сообщением [e] для логгера.
  Failure _error(String? e) => TokenRepositoryFailure(e).talk();

  @override
  Future<Either<Failure, void>> getToken() async {
    try {
      // Получаем идентификатор устройства
      final deviceId = await _localDataSource.onGetDeviceId();

      // Получаем токен из удаленного источника данных
      return await _remoteDataSource.onGetToken(deviceId: deviceId).fold(
        (failure) => Left(_error(failure.error)),
        (token) async {
          // Сохраняем токен в локальном источнике данных
          await _localDataSource.onSetToken(token: token);

          // Возвращаем успешный результат
          return const Right(null);
        },
      );
    } catch (e) {
      // В случае ошибки возвращаем ошибку репозитория
      return Left(_error(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String?>> checkToken() async {
    try {
      // Получаем токен из локального источника данных
      final localToken = await _localDataSource.onGetToken();

      // Если токен пустой, возвращаем false
      if (localToken == null || localToken.isEmpty) {
        return Left(_error('Token is empty'));
      }

      // Проверяем токен на валидность
      return await _remoteDataSource.onCheckToken(token: localToken).fold(
        (failure) => Left(_error(failure.error)),
        (token) {
          // Если удаленный токен валиден, возвращаем его
          if (token.isSuccessful) return Right(token.token);

          // Иначе возвращаем ошибку репозитория
          return Left(_error('Token is invalid'));
        },
      );
    } catch (e) {
      // В случае ошибки возвращаем ошибку репозитория
      return Left(_error(e.toString()));
    }
  }
}
