import 'package:either_dart/either.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/auth_status.dart';

/// Репозиторий для работы с авторизацией.
///
/// Содержит методы для отправки кода подтверждения, проверки кода,
/// проверки статуса авторизации и пропуска авторизации.
abstract interface class IAuthRepository {
  /// Пропускает авторизацию.
  ///
  /// Возвращает [SkipAuthFailure], если авторизация не была пропущена.
  /// Возвращает [Right<void>] если авторизация была пропущена.
  Future<Either<Failure, void>> skipAuth();

  /// Отправляет код подтверждения на указанный номер телефона.
  /// - [phone] - номер телефона.
  ///
  /// Возвращает [CreateCodeFailure], если номер телефона не был отправлен.
  /// Возвращает [Right<void>] если номер телефона был отправлен.
  Future<Either<Failure, void>> sendPhone({required String phone});

  /// Проверяет код подтверждения.
  /// - [code] - код подтверждения.
  ///
  /// Возвращает [ValidateCodeFailure], если код неверный.
  /// Возвращает [Right<void>] если код верный.
  Future<Either<Failure, void>> checkCode({required String code});

  /// Повторно отправляет код подтверждения.
  ///
  /// Возвращает [ResendCodeFailure], если номер телефона не был отправлен.
  /// Возвращает [Right<void>] если номер телефона был отправлен.
  Future<Either<Failure, void>> resendCode();

  /// Проверяет статус авторизации.
  ///
  /// Возвращает [CheckAuthStatusFailure], если статус авторизации не был получен.
  /// Возвращает [Right<AuthenticatedStatus>] если статус авторизации был получен.
  Future<Either<Failure, AuthenticatedStatus>> checkAuthStatus();
}
