part of '../../../core.dart';

@lazySingleton
class AuthInterceptor extends Interceptor {
  AuthInterceptor();

  ITokenRepository? _tokenRepository;
  Dio? _dio;

  ITokenRepository get tokenRepository =>
      _tokenRepository ??= getIt<ITokenRepository>();

  Dio get dio => _dio ??= getIt<Dio>();

  // Счетчик попыток повтора запроса
  int retryCount = 0;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Если количество попыток превышено, пропускаем ошибку дальше
    // без повтора запроса и обработки ошибки.
    if (retryCount >= 2) return handler.next(err);

    if (err.response?.statusCode == 401 || err.response?.statusCode == 402) {
      retryCount++;
      // Создаем новый токен
      return tokenRepository.createToken().fold(
        (failure) => throw Exception(failure.error),
        (_) async {
          // Получаем новый токен
          await tokenRepository.getToken().fold(
            (failure) => throw Exception(failure.error),
            (token) async {
              // Повторяем запрос с новым токеном
              err.requestOptions.headers['Authorization'] = 'Bearer $token';
              return handler.resolve(await dio.fetch(err.requestOptions));
            },
          );
        },
      );
    }

    return handler.next(err);
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra['ignoreToken'] == true) {
      return super.onRequest(options, handler);
    }

    return tokenRepository.getToken().fold(
      (_) => super.onRequest(options, handler),
      (token) {
        options.headers['Authorization'] = 'Bearer $token';

        return super.onRequest(options, handler);
      },
    );
  }
}
