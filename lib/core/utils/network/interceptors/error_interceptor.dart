part of '../../../core.dart';

/// Экземпляр [ErrorInterceptor] для обработки ошибок HTTP-запросов
/// и повтора запроса при необходимости.
@lazySingleton
class ErrorInterceptor extends InterceptorsWrapper {
  ErrorInterceptor({
    required IAppLogger logger,
  }) : _logger = logger;

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
