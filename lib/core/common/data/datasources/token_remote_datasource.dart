part of '../../../core.dart';

/// Удаленный источник данных для управления токенами аутентификации, отвечает
/// за взаимодействие с удаленным сервисом для получения нового токена.
abstract interface class ITokenRemoteDataSource {
  /// Получает новый токен аутентификации от удаленного сервиса.
  ///
  /// Возвращает:
  ///   - [String] содержащий новый токен.
  ///   - [Failure] если произошла ошибка при получении токена.
  Future<Either<Failure, String>> getToken({required String deviceId});

  /// Получает basic аутентификацию для доступа к удаленному сервису.
  ///
  /// Возвращает:
  ///  - [String] содержащий basic аутентификацию.
  Future<String> getBasicAuth();
}

/// Реализация удаленного источника данных для токена.
@LazySingleton(as: ITokenRemoteDataSource)
class TokenRemoteDataSource implements ITokenRemoteDataSource {
  /// Создает экземпляр [TokenRemoteDataSource].
  /// - [requestHandler] - обработчик запросов.
  TokenRemoteDataSource({
    required RequestHandler requestHandler,
    @Named(ApiConst.kLogin) required String basicLogin,
    @Named(ApiConst.kPassword) required String basicPassword,
  })  : _requestHandler = requestHandler,
        _basicLogin = basicLogin,
        _basicPassword = basicPassword;

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
          // 'firebase_id': '1',
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
