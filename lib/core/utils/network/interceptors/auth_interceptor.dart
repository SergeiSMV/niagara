part of '../../../core.dart';

/// [AuthInterceptor] для обработки токенов авторизации
@lazySingleton
class AuthInterceptor extends Interceptor {
  AuthInterceptor();

  /// Репозиторий для работы с токенами
  ITokenRepository? _tokenRepository;

  /// Экземпляр Dio
  Dio? _dio;

  /// Информация о сети
  INetworkInfo? _networkInfo;

  /// Локальный источник данных для авторизации
  IAuthLocalDataSource? _authLocalDataSource;

  /// Получает репозиторий для работы с токенами
  ITokenRepository get tokenRepository =>
      _tokenRepository ??= getIt<ITokenRepository>();

  /// Экземпляр Dio
  Dio get dio => _dio ??= getIt<Dio>();

  /// Локальный источник данных для авторизации
  IAuthLocalDataSource get authLocalDataSource =>
      _authLocalDataSource ??= getIt<IAuthLocalDataSource>();

  /// Информация о сети
  INetworkInfo get networkInfo => _networkInfo ??= getIt<INetworkInfo>();

  // Счетчик попыток повтора запроса для каждого запроса
  final Map<String, int> _retryCounts = {};

  /// [Mutex] для блокировки повторного запроса токена.
  final Mutex _refreshTokenGuard = Mutex();

  /// Генерирует уникальный ключ для запроса на основе метода и пути
  String _getRequestKey(RequestOptions options) =>
      '${options.method}_${options.path}';

  /// Сбрасывает счетчик попыток для конкретного запроса
  void _resetRetryCount(String requestKey) => _retryCounts.remove(requestKey);

  /// Возвращает количество попыток для конкретного запроса
  int _getRetryCount(String requestKey) => _retryCounts[requestKey] ?? 0;

  /// Увеличивает счетчик попыток для конкретного запроса
  void _incrementRetryCount(String requestKey) =>
      _retryCounts[requestKey] = (_retryCounts[requestKey] ?? 0) + 1;

  /// Логирует сообщения в консоль
  void _log(String message) => getIt<IAppLogger>().log(
        level: LogLevel.info,
        message: message,
      );

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Проверяем наличие интернета
    bool hasConnection = false;
    try {
      hasConnection = await networkInfo.hasConnection;
    } on Exception catch (e) {
      _log('[AuthInterceptor] Error while checking internet connection: $e');
      return handler.next(
        DioException(
          requestOptions: err.requestOptions,
          error: 'Failed to check internet connection',
          type: DioExceptionType.connectionError,
        ),
      );
    }

    if (!hasConnection) {
      _log('[AuthInterceptor] No internet connection');
      return handler.next(
        DioException(
          requestOptions: err.requestOptions,
          error: 'No internet connection',
          type: DioExceptionType.connectionError,
        ),
      );
    }

    // Проверяем, нужно ли обновлять токен
    final bool refreshRequired =
        err.response?.statusCode == 401 || err.response?.statusCode == 402;

    // Обработка ошибки 403 - перенаправление на авторизацию
    if (err.response?.statusCode == 403) {
      _log('[AuthInterceptor] 403 Forbidden detected, redirecting to auth');

      // Проверяем текущий статус авторизации
      final currentStatus = await authLocalDataSource.checkAuthStatus();
      if (currentStatus == AuthenticatedStatus.unauthenticated.index) {
        _log(
            '[AuthInterceptor] User already unauthenticated, skipping redirect');
        return handler.next(err);
      }

      // Очищаем локальные данные токена
      await tokenRepository.deleteToken();

      // Изменяем статус авторизации на unauthenticated
      // Это автоматически перенаправит пользователя на экран авторизации
      await authLocalDataSource.setAuthStatus(
        status: AuthenticatedStatus.unauthenticated.index,
      );

      return handler.next(err);
    }

    // Если токен не нужно обновлять, сбрасываем счетчик попыток
    // и пропускаем ошибку дальше
    if (!refreshRequired) {
      // Сбрасываем счетчик попыток для других ошибок
      _resetRetryCount(_getRequestKey(err.requestOptions));
      return handler.next(err);
    }

    // Получаем ключ запроса
    final String requestKey = _getRequestKey(err.requestOptions);
    _log('[AuthInterceptor] Trying to refresh token for request: '
        '$requestKey...');

    // Проверяем, заблокирован ли [Mutex] для обновления токена
    if (_refreshTokenGuard.isLocked) {
      _log(
        '[AuthInterceptor] Token refresh is already in progress. Waiting...',
      );
      return await _refreshTokenGuard.protect(
        () async {
          try {
            // Получаем новый токен
            await tokenRepository.getToken().fold(
              (failure) => throw Exception(failure.error),
              (token) async {
                // Повторяем запрос с новым токеном
                err.requestOptions.headers['Authorization'] = 'Bearer $token';
                _log(
                  '[AuthInterceptor] Token refresh is done by another process. '
                  'Retrying request: $requestKey...',
                );
                return handler.resolve(await dio.fetch(err.requestOptions));
              },
            );
          } on Exception catch (e) {
            _log('[AuthInterceptor] Error while refreshing token: $e');

            // Обработка TokenNotFoundFailure - перенаправление на авторизацию
            if (e is TokenNotFoundFailure) {
              _log('[AuthInterceptor] TokenNotFoundFailure detected, '
                  'redirecting to auth');

              // Проверяем текущий статус авторизации
              final currentStatus = await authLocalDataSource.checkAuthStatus();
              if (currentStatus == AuthenticatedStatus.unauthenticated.index) {
                _log(
                    '[AuthInterceptor] User already unauthenticated, skipping redirect');
                return handler.next(err);
              }

              // Изменяем статус авторизации на unauthenticated
              await authLocalDataSource.setAuthStatus(
                status: AuthenticatedStatus.unauthenticated.index,
              );
            }

            return handler.next(err);
          }
        },
      );
    }

    return await _refreshTokenGuard.protect(() async {
      _log('[AuthInterceptor] Started refreshing token for request: '
          '$requestKey...');

      // Если количество попыток превышено, пропускаем ошибку дальше
      // без повтора запроса и обработки ошибки.
      if (_getRetryCount(requestKey) >= 2) {
        _log('[AuthInterceptor] REFRESH FAILED: Retry count exceeded for '
            'request: $requestKey.');
        _resetRetryCount(requestKey); // Сбрасываем счетчик
        return handler.next(err);
      }

      // Увеличиваем счетчик попыток для текущего запроса
      _incrementRetryCount(requestKey);
      try {
        // Создаем новый токен
        return tokenRepository.createToken().fold(
          (failure) => throw Exception(failure.error),
          (_) async {
            // Получаем новый токен
            await tokenRepository.getToken().fold(
              (failure) => throw Exception(failure.error),
              (token) async {
                _log('[AuthInterceptor] Refreshed token. Retrying request: '
                    '$requestKey...');

                // Повторяем запрос с новым токеном
                err.requestOptions.headers['Authorization'] = 'Bearer $token';
                final response = await dio.fetch(err.requestOptions);

                // Если запрос успешен, сбрасываем счетчик попыток
                if (response.statusCode! < 400) {
                  _resetRetryCount(requestKey);
                }

                return handler.resolve(response);
              },
            );
          },
        );
      } on Exception catch (e) {
        _log('[AuthInterceptor] Error while refreshing token: $e');

        /// Обработка DeviceIdFailure - перенаправление на авторизацию
        if (e is DeviceIdFailure) {
          _deviceIdFailureHandler(
            authLocalDataSource,
            tokenRepository,
            err,
            handler,
            _log,
          );
        }

        /// Обработка TokenNotFoundFailure - перенаправление на авторизацию
        if (e is TokenNotFoundFailure) {
          _tokenNotFoundFailureHandler(authLocalDataSource, err, handler, _log);
        }

        return handler.next(err);
      }
    });
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

  /// Обработка ошибки DeviceIdFailure - перенаправление на авторизацию
  static Future<void> _deviceIdFailureHandler(
    IAuthLocalDataSource authLocalDataSource,
    ITokenRepository tokenRepository,
    DioException err,
    ErrorInterceptorHandler handler,
    void Function(String message) log,
  ) async {
    log('[AuthInterceptor] DeviceIdFailure detected, '
        'redirecting to auth');

    // Проверяем текущий статус авторизации
    final currentStatus = await authLocalDataSource.checkAuthStatus();
    if (currentStatus == AuthenticatedStatus.unauthenticated.index) {
      log('[AuthInterceptor] User already unauthenticated, skipping redirect');
      return handler.next(err);
    }

    // Очищаем локальные данные токена
    await tokenRepository.deleteToken();

    // Изменяем статус авторизации на unauthenticated
    // это автоматически перенаправит пользователя на экран авторизации
    await authLocalDataSource.setAuthStatus(
      status: AuthenticatedStatus.unauthenticated.index,
    );
  }

  /// Обработка ошибки TokenNotFoundFailure - перенаправление на авторизацию
  static Future<void> _tokenNotFoundFailureHandler(
    IAuthLocalDataSource authLocalDataSource,
    DioException err,
    ErrorInterceptorHandler handler,
    void Function(String message) log,
  ) async {
    log('[AuthInterceptor] TokenNotFoundFailure detected, '
        'redirecting to auth');

    // Проверяем текущий статус авторизации
    final currentStatus = await authLocalDataSource.checkAuthStatus();
    if (currentStatus == AuthenticatedStatus.unauthenticated.index) {
      log('[AuthInterceptor] User already unauthenticated, skipping redirect');
      return handler.next(err);
    }

    // Изменяем статус авторизации на unauthenticated
    // это автоматически перенаправит пользователя на экран авторизации
    await authLocalDataSource.setAuthStatus(
      status: AuthenticatedStatus.unauthenticated.index,
    );
  }
}
