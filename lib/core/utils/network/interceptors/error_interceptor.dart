part of '../../../core.dart';

/// Экземпляр [ErrorInterceptor] для обработки ошибок HTTP-запросов.
@lazySingleton
class ErrorInterceptor extends InterceptorsWrapper {
  ErrorInterceptor(this._logger);

  final IAppLogger _logger;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    _logger.handle(err, err.stackTrace);
    return handler.next(err);
  }
}
