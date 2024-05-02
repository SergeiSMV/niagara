import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/constants/keys_constants.dart';

/// Локальный источник данных для управления токенами аутентификации.
///
/// Этот источник данных отвечает за хранение и получение токена аутентификации
/// пользователя в локальном хранилище, таком как [FlutterSecureStorage] или
/// локальная база данных.
abstract interface class ITokenLocalDataSource {
  /// Сохраняет новый токен аутентификации в локальном хранилище.
  /// - [token] - новый токен, который нужно сохранить.
  ///
  /// Возвращает:
  ///   - [void] если токен был успешно сохранен.
  Future<void> setToken({required String token});

  /// Получает сохраненный токен аутентификации из локального хранилища.
  ///
  /// Возвращает:
  ///   - [String] содержащий сохраненный токен.
  Future<String?> getToken();

  /// Удаляет сохраненный токен аутентификации из локального хранилища.
  ///
  /// Возвращает:
  ///   - [void] если токен был успешно удален.
  Future<void> deleteToken();
}

/// Реализация локального источника данных для токена.
@LazySingleton(as: ITokenLocalDataSource)
class TokenLocalDataSource implements ITokenLocalDataSource {
  TokenLocalDataSource(this._storage);

  final FlutterSecureStorage _storage;

  String get _tokenKey => KeysConst.kToken;

  @override
  Future<void> setToken({required String token}) async =>
      _storage.write(key: _tokenKey, value: token);

  @override
  Future<String?> getToken() async => _storage.read(key: _tokenKey);

  @override
  Future<void> deleteToken() async => _storage.delete(key: _tokenKey);
}
