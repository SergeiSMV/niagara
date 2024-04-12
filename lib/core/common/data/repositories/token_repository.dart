part of '../../../core.dart';

@LazySingleton(as: ITokenRepository)
class TokenRepository extends BaseRepository implements ITokenRepository {
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
