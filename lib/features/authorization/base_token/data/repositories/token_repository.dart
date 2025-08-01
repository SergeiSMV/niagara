import '../../../../../core/core.dart';
import '../../domain/repositories/token_repository.dart';
import '../data_sources/token_local_data_source.dart';
import '../data_sources/token_remote_data_source.dart';

/// Репозиторий для работы с токенами авторизации
///
/// Этот класс предоставляет методы для работы с токенами авторизации,
/// такие как получение, создание и удаление токенов
///
/// Он также кеширует токены, чтобы избежать
/// нескольких запросов к хранилищам данных
@LazySingleton(as: ITokenRepository)
class TokenRepository extends BaseRepository implements ITokenRepository {
  TokenRepository(
    super._logger,
    super._networkInfo,
    this._tokenRDS,
    this._tokenLDS,
  );

  /// Удалённый источник данных для получения токенов
  final ITokenRemoteDataSource _tokenRDS;

  /// Локальный источник данных для получения токенов
  final ITokenLocalDataSource _tokenLDS;

  // Кешируем токен, чтобы избежать нескольких запросов к хранилищам данных
  String? _cachedToken;

  /// Возвращает ошибку, которая может возникнуть при работе с токенами
  @override
  Failure get failure => const TokenRepositoryFailure();

  /// Создаёт токен авторизации
  @override
  Future<Either<Failure, void>> createToken() => execute(_createToken);

  /// Получает токен авторизации
  @override
  Future<Either<Failure, String>> getToken() => execute(_getToken);

  /// Удаляет токен авторизации
  @override
  Future<Either<Failure, void>> deleteToken() => execute(_deleteToken);

  /// Создаёт токен авторизации
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

        // Кешируем токен
        _cachedToken = creds.token;

        // Сохраняем токен и device_id в хранилище
        Future.wait([
          _tokenLDS.setToken(token: creds.token),
          _tokenLDS.setDeviceId(deviceId: creds.deviceId ?? ''),
        ]);
      },
    );
  }

  /// Получает токен авторизации из кеша или хранилища
  Future<String> _getToken() async {
    if (_cachedToken != null) return _cachedToken!;

    // Получаем токен из хранилища
    final localToken = await _tokenLDS.getToken();

    // Если токен не найден, бросаем ошибку TokenNotFoundFailure
    if (localToken == null || localToken.isEmpty) {
      throw const TokenNotFoundFailure();
    }

    // Кешируем токен
    _cachedToken = localToken;

    // Возвращаем токен
    return localToken;
  }

  /// Удаляет токен авторизации из кеша и хранилища
  Future<void> _deleteToken() async {
    // Удаляем токен из хранилища
    await _tokenLDS.deleteToken();

    // Очищаем кеш токена
    _cachedToken = null;
  }
}
