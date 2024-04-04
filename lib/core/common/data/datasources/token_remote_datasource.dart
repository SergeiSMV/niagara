part of '../../../core.dart';

/// Абстрактный интерфейс удаленного источника данных для токена.
abstract interface class ITokenRemoteDataSource {
  /// Возвращает токен.
  Future<Either<Failure, String>> onGetToken({required String deviceId});

  /// Проверяет токен.
  Future<Either<Failure, TokenModel>> onCheckToken({required String token});
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

  @override
  Future<Either<Failure, String>> onGetToken({
    required String deviceId,
  }) =>
      _requestHandler.sendRequest<String>(
        request: (dio) => dio.post(
          ApiConst.kGetToken,
          data: {
            'device_id': deviceId,
            // 'firebase_id': '1',
          },
        ),
        converter: (json) => json['token'] as String,
        failure: TokenRemoteFailure.new,
      );

  @override
  Future<Either<Failure, TokenModel>> onCheckToken({
    required String token,
  }) =>
      _requestHandler.sendRequest<TokenModel>(
        request: (dio) => dio.get(
          ApiConst.kCheckToken,
          queryParameters: {
            'token': token,
          },
        ),
        converter: TokenModel.fromJson,
        failure: TokenRemoteFailure.new,
      );
}
