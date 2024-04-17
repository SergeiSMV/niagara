part of '../../core.dart';

abstract interface class IPermissionsService {
  /// Открывает настройки приложения.
  Future<bool> openSettings();

  /// Проверяет, есть ли у приложения разрешение на использование геолокации.
  Future<PermissionStatus> checkLocationPermission();
}

@LazySingleton(as: IPermissionsService)
class PermissionsService implements IPermissionsService {
  @override
  Future<bool> openSettings() async => openAppSettings();

  @override
  Future<PermissionStatus> checkLocationPermission() async {
    await Permission.location.request();
    final status = await Permission.location.status;
    return status;
  }
}
