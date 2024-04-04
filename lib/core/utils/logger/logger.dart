import 'package:talker_flutter/talker_flutter.dart';

/// Абстракция логгера приложения.
abstract interface class IAppLogger {
  /// Запись критического сообщения.
  void critical(String message, [Object? error, StackTrace? stackTrace]);

  /// Запись сообщения об ошибке.
  void error(String message, [Object? error, StackTrace? stackTrace]);

  /// Запись предупреждения.
  void warning(String message, [Object? error, StackTrace? stackTrace]);

  /// Запись информационного сообщения.
  void info(String message, [Object? error, StackTrace? stackTrace]);

  /// Запись отладочного сообщения.
  void debug(String message, [Object? error, StackTrace? stackTrace]);

  /// Запись подробного сообщения.
  void verbose(String message, [Object? error, StackTrace? stackTrace]);

  /// Обработка ошибки.
  void handle(Object error, [StackTrace? stackTrace]);
}

/// Реализация логгера приложения на основе [Talker].
class AppLogger implements IAppLogger {
  /// Создает экземпляр логгера приложения.
  /// [talker] - экземпляр [Talker] для записи логов.
  AppLogger({required Talker talker}) : _talker = talker;

  final Talker _talker;

  @override
  void critical(String message, [Object? error, StackTrace? stackTrace]) =>
      _talker.critical(message, error, stackTrace);

  @override
  void error(String message, [Object? error, StackTrace? stackTrace]) =>
      _talker.error(message, error, stackTrace);

  @override
  void warning(String message, [Object? error, StackTrace? stackTrace]) =>
      _talker.warning(message, error, stackTrace);

  @override
  void info(String message, [Object? error, StackTrace? stackTrace]) =>
      _talker.info(message, error, stackTrace);

  @override
  void debug(String message, [Object? error, StackTrace? stackTrace]) =>
      _talker.debug(message, error, stackTrace);

  @override
  void verbose(String message, [Object? error, StackTrace? stackTrace]) =>
      _talker.verbose(message, error, stackTrace);

  @override
  void handle(Object error, [StackTrace? stackTrace]) =>
      _talker.handle(error, stackTrace);
}
