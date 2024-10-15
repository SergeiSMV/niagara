import 'dart:async';

import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/keys_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Определяет интерфейс для AuthLocalDataSource, который отвечает за
/// управление локальным хранением данных, связанных с аутентификацией.
///
/// Этот интерфейс предоставляет методы для установки и получения статуса
/// аутентификации пользователя, который обычно хранится в локальном хранилище,
/// таком как SharedPreferences.
abstract interface class IAuthLocalDataSource {
  /// Устанавливает статус аутентификации пользователя в локальном хранилище.
  ///
  /// [status] - новый статус аутентификации для сохранения.
  Future<void> setAuthStatus({required int status});

  /// Получает текущий статус аутентификации пользователя из локального
  /// хранилища.
  ///
  /// Возвращает текущий статус аутентификации в виде целочисленного значения.
  Future<int> checkAuthStatus();

  /// Возвращает [Stream] с изменениями статуса аутентификации.
  Stream<int> get authStatusStream;
}

@LazySingleton(as: IAuthLocalDataSource)
class AuthLocalDataSource implements IAuthLocalDataSource {
  AuthLocalDataSource(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;
  final StreamController<int> _authStatusController =
      StreamController.broadcast();

  /// Вовзвращает [Stream] с изменениями статуса авторизации.
  @override
  Stream<int> get authStatusStream => _authStatusController.stream;

  static const _authStatusKey = KeysConst.kAuthStatus;

  @override
  Future<void> setAuthStatus({required int status}) async {
    await _sharedPreferences.setInt(_authStatusKey, status);

    // Если произошёл выход из аккаунта, очищаем базу данных.
    if (status == 1) {
      await getIt<AppDatabase>().clearAllTables();
    }

    _authStatusController.add(status);
  }

  @override
  Future<int> checkAuthStatus() =>
      Future.value(_sharedPreferences.getInt(_authStatusKey) ?? 0);
}
