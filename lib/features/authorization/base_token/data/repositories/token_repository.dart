import 'package:niagara_app/core/common/data/services/device_id_service.dart';
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
    this._deviceIdService,
  );

  final ITokenRemoteDataSource _tokenRDS;
  final ITokenLocalDataSource _tokenLDS;
  final IDeviceIdService _deviceIdService;

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
    final deviceId = await _deviceIdService.getUniqueId();
    if (deviceId.isLeft) throw const DeviceIdFailure();

    await _tokenRDS.getToken(deviceId: deviceId.right).fold(
      (failure) => throw GetTokenFailure(failure.error),
      (token) async {
        _cachedToken = token;
        await _tokenLDS.setToken(token: token);
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
