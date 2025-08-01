import '../../../../../core/core.dart';
import '../../domain/repositories/token_repository.dart';
import '../data_sources/token_local_data_source.dart';
import '../data_sources/token_remote_data_source.dart';

@LazySingleton(as: ITokenRepository)
class TokenRepository extends BaseRepository implements ITokenRepository {
  TokenRepository(
    super._logger,
    super._networkInfo,
    this._tokenRDS,
    this._tokenLDS,
  );

  final ITokenRemoteDataSource _tokenRDS;
  final ITokenLocalDataSource _tokenLDS;

  // Кешируем токен, чтобы избежать нескольких запросов к хранилищам данных.
  String? _cachedToken;

  @override
  Failure get failure => const TokenRepositoryFailure();

  @override
  Future<Either<Failure, void>> createToken() => execute(_createToken);

  @override
  Future<Either<Failure, String>> getToken() => execute(_getToken);

  @override
  Future<Either<Failure, void>> deleteToken() => execute(_deleteToken);

  Future<void> _createToken() async {
    // Пытаемся получить [deviceId]. Если он `null`, значит это первая
    // авторизация.
    final String? deviceId = await _tokenLDS.getDeviceId();

    await _tokenRDS.getToken(deviceId: deviceId).fold(
      (failure) => throw GetTokenFailure(failure.error),
      (creds) async {
        // Проверяем device_id от сервера
        if (creds.deviceId?.isEmpty ?? true) {
          // Этап 2: Удаление локальных данных
          _cachedToken = null; // Очищаем кеш токена
          await Future.wait([
            _tokenLDS.deleteToken(), // Удаляем токен из FlutterSecureStorage
            _tokenLDS.setDeviceId(deviceId: ''), // Очищаем device_id
          ]);

          // Обработка ошибки - бросаем ошибку DeviceIdFailure для
          // перехвата в [AuthInterceptor]
          throw const DeviceIdFailure('Empty device_id received from server');
        }

        _cachedToken = creds.token;

        Future.wait([
          _tokenLDS.setToken(token: creds.token),
          _tokenLDS.setDeviceId(deviceId: creds.deviceId ?? ''),
        ]);
      },
    );
  }

  Future<String> _getToken() async {
    if (_cachedToken != null) return _cachedToken!;

    final localToken = await _tokenLDS.getToken();

    if (localToken == null || localToken.isEmpty) {
      throw const TokenNotFoundFailure();
    }

    _cachedToken = localToken;
    return localToken;
  }

  Future<void> _deleteToken() async {
    await _tokenLDS.deleteToken();
    _cachedToken = null;
  }
}
