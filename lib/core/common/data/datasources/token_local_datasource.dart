part of '../../../core.dart';

/// Абстракция локального источника данных для токена.
abstract interface class ITokenLocalDataSource {
  /// Устанавливает токен.
  Future<void> onSetToken({required String token});

  /// Возвращает токен.
  Future<String?> onGetToken();

  /// Удаляет токен.
  Future<void> onDeleteToken();

  /// Возвращает идентификатор устройства.
  Future<String> onGetDeviceId();
}

/// Реализация локального источника данных для токена.
@LazySingleton(as: ITokenLocalDataSource)
class TokenLocalDataSource implements ITokenLocalDataSource {
  /// - [storage] - хранилище токена.
  TokenLocalDataSource({
    required FlutterSecureStorage storage,
    required Uuid uuid,
  })  : _storage = storage,
        _uuid = uuid;

  /// Хранилище токена в шифрованном виде.
  final FlutterSecureStorage _storage;

  /// Уникальный идентификатор для устройства.
  final Uuid _uuid;

  String? get _tokenKey => ApiConst.kToken;
  String? get _deviceIdKey => ApiConst.kDeviceId;

  Exception get _tokenKeyException => Exception('Token key is not set');
  Exception get _deviceIdKeyException => Exception('DeviceId key is not set');

  @override
  Future<void> onSetToken({required String token}) {
    if (_tokenKey == null) throw _tokenKeyException;
    return _storage.write(key: _tokenKey!, value: token);
  }

  @override
  Future<String?> onGetToken() async {
    if (_tokenKey == null) throw _tokenKeyException;
    return _storage.read(key: _tokenKey!);
  }

  @override
  Future<void> onDeleteToken() {
    if (_tokenKey == null) throw _tokenKeyException;
    return _storage.delete(key: _tokenKey!);
  }

  @override
  Future<String> onGetDeviceId() async {
    if (_deviceIdKey == null) throw _deviceIdKeyException;
    final deviceId = await _storage.read(key: _deviceIdKey!);
    if (deviceId != null) return deviceId;
    final newDeviceId = _uuid.v4();
    await _storage.write(key: _deviceIdKey!, value: newDeviceId);
    return newDeviceId;
  }
}
