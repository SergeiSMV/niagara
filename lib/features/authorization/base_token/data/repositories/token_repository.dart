import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/authorization/base_token/data/data_sources/token_local_data_source.dart';
import 'package:niagara_app/features/authorization/base_token/data/data_sources/token_remote_data_source.dart';
import 'package:niagara_app/features/authorization/base_token/domain/repositories/token_repository.dart';

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
        _cachedToken = creds.token;

        Future.wait([
          _tokenLDS.setToken(token: creds.token),
          _tokenLDS.setDeviceId(deviceId: creds.deviceId),
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
