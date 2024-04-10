part of '../../../core.dart';

/// Репозиторий для управления токенами аутентификации пользователя.
///
/// Этот репозиторий отвечает за взаимодействие с локальным источником данных
/// и удаленным источником данных для выполнения операций, связанных с токеном,
/// таких как создание, проверка и получение токена аутентификации пользователя.
@LazySingleton(as: ITokenRepository)
class TokenRepository extends BaseRepository implements ITokenRepository {
  /// Конструирует экземпляр [TokenRepository].
  ///
  /// - [remoteDataSource] используется для взаимодействия с удаленным сервисом
  /// токена.
  /// - [localDataSource] используется для хранения и получения токена локально.
  /// - [deviceIdProvider] используется для получения уникального идентификатора
  /// - [logger] используется для ведения журнала ошибок и другой
  /// соответствующей информации.
  TokenRepository({
    required ITokenRemoteDataSource remoteDataSource,
    required ITokenLocalDataSource localDataSource,
    required IDeviceIdDatasource deviceIdProvider,
    required super.logger,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _deviceIdProvider = deviceIdProvider;

  final ITokenRemoteDataSource _remoteDataSource;
  final ITokenLocalDataSource _localDataSource;
  final IDeviceIdDatasource _deviceIdProvider;

  // Кешируем токен, чтобы избежать нескольких запросов к хранилищам данных.
  String? _cachedToken;

  @override
  Future<Either<Failure, void>> createToken() =>
      execute(_createToken, const CreateTokenFailure());

  @override
  Future<Either<Failure, String>> getToken() =>
      execute(_getToken, const GetTokenFailure());

  Future<void> _createToken() async {
    final deviceId = await _deviceIdProvider.getOrCreateUniqueId();

    if (deviceId.isLeft) throw const DeviceIdFailure();

    await _remoteDataSource.getToken(deviceId: deviceId.right).fold(
      (failure) => throw GetTokenFailure(failure.error),
      (token) async {
        _cachedToken = null;
        await _localDataSource.setToken(token: token);
      },
    );
  }

  Future<String> _getToken() async {
    if (_cachedToken != null) return _cachedToken!;

    final localToken = await _localDataSource.getToken();

    if (localToken == null || localToken.isEmpty) {
      throw const TokenNotFoundFailure();
    }

    _cachedToken = localToken;
    return localToken;
  }
}
