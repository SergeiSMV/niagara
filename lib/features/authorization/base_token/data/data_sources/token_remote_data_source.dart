import 'dart:convert';

import 'package:niagara_app/core/core.dart';

/// Удаленный источник данных для управления токенами аутентификации, отвечает
/// за взаимодействие с удаленным сервисом для получения нового токена.
abstract interface class ITokenRemoteDataSource {
  /// Получает новый токен аутентификации от удаленного сервиса.
  ///
  /// Возвращает:
  ///   - [String] содержащий новый токен.
  ///   - [Failure] если произошла ошибка при получении токена.
  Future<Either<Failure, String>> getToken({
    required String deviceId,
  });

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
  Future<Either<Failure, String>> getToken({
    required String deviceId,
  }) async {
    final base64 = await getBasicAuth();

    return _requestHandler.sendRequest<String, Map<String, dynamic>>(
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
          'device_id': deviceId,
        },
      ),
      converter: (json) => json['token'] as String,
      failure: GetTokenFailure.new,
    );
  }

  @override
  Future<String> getBasicAuth() async {
    return base64Encode(utf8.encode('$_basicLogin:$_basicPassword'));
  }
}
