import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// [TalkerObserver] для отправки ошибок в Crashlytics.
class CrashlyticsTalkerObserver extends TalkerObserver {
  const CrashlyticsTalkerObserver();

  /// Экземпляр Crashlytics.
  FirebaseCrashlytics get _crashlytics => FirebaseCrashlytics.instance;

  /// Список статус-кодов, которые не являются критичными
  static const _nonFatalStatusCodes = [401, 402, 500];

  @override
  void onLog(TalkerData log) => _crashlytics.log(log.generateTextMessage());

  @override
  Future<void> onError(TalkerError err) async {
    // Проверяем, является ли ошибка DioException с некритичным статус-кодом
    if (_isNonFatalDioError(err.error)) return;

    /// Отправляем ошибку в Crashlytics.
    await _crashlytics.recordError(
      err.error,
      err.stackTrace,
      reason: err.message,
      fatal: err.logLevel == LogLevel.critical,
    );
  }

  @override
  Future<void> onException(TalkerException err) async {
    // Проверяем, является ли ошибка DioException с некритичным статус-кодом
    if (_isNonFatalDioError(err.exception)) return;

    /// Отправляем ошибку в Crashlytics.
    await _crashlytics.recordError(
      err.exception,
      err.stackTrace,
      reason: err.message,
      fatal: err.logLevel == LogLevel.critical,
    );
  }

  /// Проверяет, является ли ошибка DioException с некритичным статус-кодом
  bool _isNonFatalDioError(Object? error) {
    /// Проверяем, является ли ошибка DioException с некритичным статус-кодом
    if (error is DioException) {
      /// Получаем статус-код ответа
      final statusCode = error.response?.statusCode;

      /// Проверяем, является ли статус-код некритичным
      return statusCode != null && _nonFatalStatusCodes.contains(statusCode);
    }

    /// Если ошибка не является DioException, считаем её критичной
    return false;
  }
}
