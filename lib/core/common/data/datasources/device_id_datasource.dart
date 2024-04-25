import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/constants/keys_constants.dart';

/// Локальный источник данных для управления уникальным идентификатором
/// устройства.
abstract interface class IDeviceIdDatasource {
  /// Получает уникальный идентификатор устройства или создает новый.
  ///
  /// Возвращает:
  ///   - [String] содержащий идентификатор устройства.
  ///   - [Failure] если произошла ошибка при получении идентификатора.
  Future<Either<Failure, String>> getOrCreateUniqueId();

  /// Получает сохраненный уникальный идентификатор устройства.
  ///
  /// Возвращает:
  ///   - [String] содержащий идентификатор устройства.
  ///   - [Failure] если идентификатор не найден.
  Future<Either<Failure, String>> getUniqueId();
}

@LazySingleton(as: IDeviceIdDatasource)
class DeviceIdDatasource implements IDeviceIdDatasource {
  DeviceIdDatasource({
    required DeviceInfoPlugin deviceInfoPlugin,
    required FlutterSecureStorage secureStorage,
  })  : _deviceInfoPlugin = deviceInfoPlugin,
        _secureStorage = secureStorage;

  static const _uniqueIdKey = KeysConst.kDeviceId;

  final DeviceInfoPlugin _deviceInfoPlugin;
  final FlutterSecureStorage _secureStorage;

  /// Получает уникальный идентификатор устройства или создает новый.
  ///
  /// Если уникальный идентификатор уже существует, возвращает его.
  /// В противном случае создает уникальный идентификатор, используя
  /// [DeviceInfoPlugin], и сохраняет его в [FlutterSecureStorage]
  /// перед возвратом.
  @override
  Future<Either<Failure, String>> getOrCreateUniqueId() async {
    final existingId = await getUniqueId();
    return existingId.fold(
      (failure) async {
        try {
          final deviceInfo = await _deviceInfoPlugin.deviceInfo;
          String? newId;

          if (deviceInfo is AndroidDeviceInfo) {
            newId = deviceInfo.id;
          } else if (deviceInfo is IosDeviceInfo) {
            newId = deviceInfo.identifierForVendor;
          }

          if (newId != null) {
            await _secureStorage.write(key: _uniqueIdKey, value: newId);
            return Right(newId);
          } else {
            return const Left(DeviceIdFailure());
          }
        } catch (e) {
          return Left(DeviceIdFailure(e.toString()));
        }
      },
      Right.new,
    );
  }

  /// Получает сохраненный уникальный идентификатор устройства.
  /// Если идентификатор не найден, возвращает [DeviceIdFailure].
  @override
  Future<Either<Failure, String>> getUniqueId() async {
    final storedId = await _secureStorage.read(key: _uniqueIdKey);
    if (storedId != null) {
      return Right(storedId);
    } else {
      return const Left(DeviceIdFailure());
    }
  }
}
