part of '../../../core.dart';

/// Локальный источник данных для управления токенами аутентификации.
///
/// Этот источник данных отвечает за хранение и получение токена аутентификации
/// пользователя в локальном хранилище, таком как SharedPreferences или
/// локальная база данных.
abstract interface class ITokenLocalDataSource {
  /// Сохраняет новый токен аутентификации в локальном хранилище.
  ///
  /// [token] - новый токен, который нужно сохранить.
  ///
  /// Возвращает:
  ///   - [Right<void>] если токен был успешно сохранен.
  ///   - [Left<Failure>] если произошла ошибка при сохранении токена.
  Future<void> setToken({required String token});

  /// Получает сохраненный токен аутентификации из локального хранилища.
  ///
  /// Возвращает:
  ///   - [Right<String>] содержащий сохраненный токен.
  ///   - [Left<Failure>] если токен не найден или ошибка при получении.
  Future<String?> getToken();

  /// Удаляет сохраненный токен аутентификации из локального хранилища.
  ///
  /// Возвращает:
  ///   - [Right<void>] если токен был успешно удален.
  ///   - [Left<Failure>] если произошла ошибка при удалении токена.
  Future<void> deleteToken();
}

/// Реализация локального источника данных для токена.
@LazySingleton(as: ITokenLocalDataSource)
class TokenLocalDataSource implements ITokenLocalDataSource {
  /// - [storage] - хранилище токена.
  TokenLocalDataSource({
    required FlutterSecureStorage storage,
  }) : _storage = storage;

  /// Хранилище токена в шифрованном виде.
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
