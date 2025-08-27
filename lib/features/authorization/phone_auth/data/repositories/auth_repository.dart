import 'package:talker_flutter/talker_flutter.dart';

import '../../../../../core/core.dart';
import '../../../../../core/dependencies/di.dart';
import '../../../../../core/utils/enums/auth_status.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';

/// Репозиторий для работы с аутентификацией
///
/// Этот класс предоставляет методы для работы с аутентификацией,
/// такие как проверка статуса авторизации, отправка кода,
/// проверка кода, выход из аккаунта и т.д.
@LazySingleton(as: IAuthRepository)
class AuthRepository extends BaseRepository implements IAuthRepository {
  AuthRepository(
    super._logger,
    super._networkInfo,
    this._authLDS,
    this._authRDS,
  );

  /// Локальный источник данных для работы с аутентификацией
  final IAuthLocalDataSource _authLDS;

  /// Удаленный источник данных для работы с аутентификацией
  final IAuthRemoteDatasource _authRDS;

  /// Кешируем номер телефона, чтобы избежать нескольких запросов к хранилищам.
  String? _cachedPhone;

  /// Возвращает ошибку, которая может возникнуть при работе с аутентификацией
  @override
  Failure get failure => const AuthRepositoryFailure();

  /// Возвращает поток статуса авторизации
  @override
  Stream<AuthenticatedStatus> get authStatusStream =>
      _authLDS.authStatusStream.distinct().map((status) {
        final verbose = AuthenticatedStatus.values[status];

        getIt<IAppLogger>().log(
          level: LogLevel.info,
          message: 'Auth status changed to: $verbose',
        );

        return verbose;
      });

  /// Выход из аккаунта
  @override
  Future<Either<Failure, void>> logout() => execute(_logout);

  /// Проверка статуса авторизации
  @override
  Future<Either<Failure, AuthenticatedStatus>> checkAuthStatus() =>
      execute(_checkAuthStatus);

  /// Отправка кода на телефон
  @override
  Future<Either<Failure, void>> sendPhone({required String phone}) =>
      execute(() => _sendPhone(phone));

  /// Пропуск авторизации
  @override
  Future<Either<Failure, void>> skipAuth() => execute(_skipAuth);

  /// Переотправка кода на телефон
  @override
  Future<Either<Failure, void>> resendCode() {
    if (_cachedPhone == null) {
      return Future.value(const Left(ResendCodeFailure()));
    }

    return execute(() => _sendPhone(_cachedPhone!));
  }

  /// Проверка кода подтверждения
  @override
  Future<Either<Failure, void>> checkCode({
    required String code,
    required bool user,
    required bool marketing,
  }) =>
      execute(
        () => _checkCode(
          code: code,
          user: user,
          marketing: marketing,
        ),
      );

  /// Проверка статуса авторизации
  Future<AuthenticatedStatus> _checkAuthStatus() async => _authLDS
      .checkAuthStatus()
      .then((value) => AuthenticatedStatus.values[value]);

  /// Отправка кода на телефон
  Future<void> _sendPhone(String phone) async {
    _cachedPhone = phone;
    return _authRDS.onCreateCode(phone: phone).fold(
      (failure) => throw CreateCodeFailure(failure.error),
      (isValid) {
        if (!isValid) throw const CreateCodeFailure();
        return;
      },
    );
  }

  /// Проверяет код подтверждения
  Future<void> _checkCode({
    required String code,
    required bool user,
    required bool marketing,
  }) async {
    if (_cachedPhone == null) throw const PhoneNotFoundFailure();

    // Сначала проверяем код
    final codeValidation = await _authRDS.onConfirmCode(
      phone: _cachedPhone!,
      code: code,
    );

    // Если код не валиден, выбрасываем ошибку
    return codeValidation.fold(
      (failure) => throw ValidateCodeFailure(failure.error),
      (isValid) async {
        if (!isValid) throw const ValidateCodeFailure();

        // Устанавливаем статус авторизованного пользователя
        await _authLDS.setAuthStatus(
          status: AuthenticatedStatus.authenticated.index,
        );

        // Если код валиден, передаем информацию о согласии с положениями
        await _authRDS
            .confirmPrivacy(
          user: user,
          marketing: marketing,
        )
            .fold(
          (failure) => throw failure,
          (success) async {
            if (!success) throw const ConfirmPrivacyFailure();
          },
        );

        _cachedPhone = null;
      },
    );
  }

  /// Пропуск авторизации
  Future<void> _skipAuth() => _authLDS.setAuthStatus(
        status: AuthenticatedStatus.unauthenticated.index,
      );

  /// Выход из аккаунта
  Future<void> _logout() => _authRDS.logout().fold(
        (failure) => throw AuthRepositoryFailure(failure.error),
        (success) => _authLDS.setAuthStatus(
          status: AuthenticatedStatus.unauthenticated.index,
        ),
      );
}
