part of '../../../core.dart';

/// Удаленный источник данных для управления токенами аутентификации.
///
/// Этот источник данных отвечает за взаимодействие с удаленным сервисом токенов
/// для выполнения операций, таких как получение нового токена, проверка
/// действительности существующего токена и обновление истекшего токена.
abstract interface class ITokenRemoteDataSource {
  /// Получает новый токен аутентификации от удаленного сервиса.
  ///
  /// Возвращает:
  ///   - [Right<String>] содержащий новый токен.
  ///   - [Left<Failure>] если произошла ошибка при получении токена.
  Future<Either<Failure, String>> getToken({required String deviceId});

  /// Получает базовую аутентификацию для доступа к удаленному сервису.
  Future<String> getBasicAuth();
}

/// Реализация удаленного источника данных для токена.
@LazySingleton(as: ITokenRemoteDataSource)
class TokenRemoteDataSource implements ITokenRemoteDataSource {
  /// Создает экземпляр [TokenRemoteDataSource].
  /// - [requestHandler] - обработчик запросов.
  TokenRemoteDataSource({
    required RequestHandler requestHandler,
  }) : _requestHandler = requestHandler;

  final RequestHandler _requestHandler;

  String get _login => dotenv.get(
        ApiConst.kLogin,
        fallback: 'NO_LOGIN',
      );

  String get _password => dotenv.get(
        ApiConst.kPassword,
        fallback: 'NO_PASSWORD',
      );

  @override
  Future<Either<Failure, String>> getToken({
    required String deviceId,
  }) async {
    final base64 = await getBasicAuth();

    return _requestHandler.sendRequest<String>(
      request: (dio) => dio.post(
        ApiConst.kGetToken,
        options: Options(
          headers: {
            'Authorization': 'Basic $base64',
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
  Future<String> getBasicAuth() async =>
      base64Encode(utf8.encode('$_login:$_password'));
}
