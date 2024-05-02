import 'package:device_info_plus/device_info_plus.dart';
import 'package:niagara_app/core/core.dart';

abstract interface class IDeviceIdService {
  Future<Either<Failure, String>> getUniqueId();
}

@LazySingleton(as: IDeviceIdService)
class DeviceIdService implements IDeviceIdService {
  DeviceIdService(this._deviceInfoPlugin);

  final DeviceInfoPlugin _deviceInfoPlugin;

  /// Получает уникальный идентификатор устройства.
  /// Если идентификатор не найден, возвращает [DeviceIdFailure].
  @override
  Future<Either<Failure, String>> getUniqueId() async {
    try {
      final deviceInfo = await _deviceInfoPlugin.deviceInfo;
      String? newId;

      if (deviceInfo is AndroidDeviceInfo) {
        newId = deviceInfo.id;
      } else if (deviceInfo is IosDeviceInfo) {
        newId = deviceInfo.identifierForVendor;
      }

      if (newId != null) {
        return Right(newId);
      } else {
        return const Left(DeviceIdFailure());
      }
    } catch (e) {
      return Left(DeviceIdFailure(e.toString()));
    }
  }
}
