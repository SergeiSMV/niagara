import 'dart:convert';

import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/authorization/base_token/domain/models/credentials.dart';

/// Удаленный источник данных для управления токенами аутентификации, отвечает
/// за взаимодействие с удаленным сервисом для получения нового токена.
abstract interface class ITokenRemoteDataSource {
  /// Получает новый токен аутентификации от удаленного сервиса.
  ///
  /// Если [deviceId] не указан, считается, что происходит первая авторизация. В
  /// таком случае сервер выпишет пару [token] / [deviceId] и вернёт их.
  ///
  /// Второй далее нужно будет использовать в качестве `Refresh-Token` и
  /// постоянно передавать в этот метод.
  Future<Either<Failure, CredentialsDto>> getToken({String? deviceId});

  /// Получает basic аутентификацию для доступа к удаленному сервису.
  ///
  /// Возвращает:
  ///  - [String] содержащий basic аутентификацию.
  Future<String> getBasicAuth();
}

/// Реализация удаленного источника данных для токена.
@LazySingleton(as: ITokenRemoteDataSource)
class TokenRemoteDataSource implements ITokenRemoteDataSource {
  TokenRemoteDataSource(
    this._requestHandler,
    @Named(ApiConst.kLogin) this._basicLogin,
    @Named(ApiConst.kPassword) this._basicPassword,
  );

  final RequestHandler _requestHandler;

  final String _basicLogin;

  final String _basicPassword;

  @override
  Future<Either<Failure, CredentialsDto>> getToken({
    String? deviceId,
  }) async {
    final base64 = await getBasicAuth();

    return _requestHandler.sendRequest<CredentialsDto, Map<String, dynamic>>(
      request: (dio) => dio.post(
        ApiConst.kGetToken,
        options: Options(
          headers: {
            'Authorization': 'Basic $base64',
          },
          extra: {
            'ignoreToken': true,
          },
        ),
        data: {
          'device_id': deviceId ?? '',
        },
      ),
      converter: CredentialsDto.fromJson,
      failure: GetTokenFailure.new,
    );
  }

  @override
  Future<String> getBasicAuth() async {
    return base64Encode(utf8.encode('$_basicLogin:$_basicPassword'));
  }
}
