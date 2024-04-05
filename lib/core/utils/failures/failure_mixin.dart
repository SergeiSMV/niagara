part of '../../core.dart';

/// Миксин для логирования ошибок.
mixin LogMixin {
  IAppLogger get _logger => getIt<IAppLogger>();

  /// Вывод ошибки в консоль и лог.
  Failure logFailure(Failure f) {
    final msg = _buildMessage(f);
    _logger.warning(msg);
    return f;
  }

  /// Вывод исключения в консоль и лог.
  Failure logError(
    Failure f,
    Object e, [
    StackTrace? st,
    dynamic msg,
  ]) {
    final msg = _buildMessage(f);
    _logger.handle(e, st, msg);
    return f;
  }

  /// Подготовка сообщения об ошибке.
  String _buildMessage(Failure f) {
    final where = runtimeType.toString();
    final who = f.runtimeType.toString();
    final errorMessage = f.error ?? 'No error message';
    return '$where :: $who :: $errorMessage';
  }
}
