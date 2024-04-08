part of '../../core.dart';

/// Абстракция логгера приложения.
abstract interface class IAppLogger {
  void log({
    required LogLevel level,
    required String message,
    Object? error,
    StackTrace? stackTrace,
  });

  void handle(Object error, [StackTrace? stackTrace, dynamic msg]);
}

/// Реализация логгера приложения на основе [Talker].
@LazySingleton(as: IAppLogger)
class AppLogger implements IAppLogger {
  AppLogger({
    required Talker talker,
  }) : _talker = talker;

  final Talker _talker;

  @override
  void log({
    required LogLevel level,
    required String message,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      switch (level) {
        LogLevel.debug => _talker.debug(message, error, stackTrace),
        LogLevel.info => _talker.info(message, error, stackTrace),
        LogLevel.warning => _talker.warning(message, error, stackTrace),
        LogLevel.error => _talker.error(message, error, stackTrace),
        LogLevel.critical => _talker.critical(message, error, stackTrace),
        LogLevel.verbose => _talker.verbose(message, error, stackTrace),
      };

  @override
  void handle(Object error, [StackTrace? stackTrace, dynamic msg]) =>
      _talker.handle(error, stackTrace, msg);
}
