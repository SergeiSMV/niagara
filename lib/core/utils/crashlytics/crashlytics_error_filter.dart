import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../core.dart';

/// Фильтр для отсеивания некритичных ошибок.
abstract interface class CrashlyticsErrorFilter {
  /// Список некритичных ошибок.
  static const _nonFatals = [
    /// Ошибка при загрузке изображения в GPU из-за нахождения приложения
    /// в фоновом режиме. Не вызывает проблем в UX и устраняется сама собой
    /// после открытия приложения.
    /// Source: https://github.com/flutter/flutter/issues/159397
    'Image upload failed due to loss of GPU access',
  ];

  /// Список статус-кодов, которые не являются критичными.
  static const _serverFaultStatusCodes = [
    /// Ошибка авторизации.
    401,

    /// Ошибка авторизации (токен истек), автоматически обрабатывается AuthInterceptor.
    402,

    /// Внутренняя ошибка сервера.
    500,
  ];

  /// Проверяет, является ли ошибка критичной.
  static bool isErrorFatal(FlutterErrorDetails error) {
    final Object? exception = error.exception;
    final String message = error.exceptionAsString();

    // Проверяем ошибки взаимодействия с сервером.
    if (exception is DioException) {
      final response = exception.response;
      if (_serverFaultStatusCodes.contains(response?.statusCode)) {
        return false;
      }
    }

    // Проверяем ошибки, которые не являются критичными.
    final bool isNonFatal = _nonFatals.any(message.contains);
    return !isNonFatal;
  }
}
