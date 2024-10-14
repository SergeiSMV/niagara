part of '../../../core.dart';

abstract interface class IPermissionsService {
  /// Открывает настройки приложения.
  Future<bool> openSettings();

  /// Проверяет, есть ли у приложения разрешение на использование геолокации.
  Future<PermissionStatus> checkLocationPermission();

  /// Проверяет, есть ли у приложения разрешение на отправку уведомлений.
  Future<PermissionStatus> checkNotificationPermission();

  /// Проверяет, включена ли геолокация на устройстве.
  Future<bool> checkGeopositionEnabled();

  /// Открывает настройки геолокации.
  Future<bool> openLocationSettings();
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

  @override
  Future<PermissionStatus> checkNotificationPermission() async {
    await Permission.notification.request();
    final status = await Permission.notification.status;
    return status;
  }

  @override
  Future<bool> checkGeopositionEnabled() =>
      Geolocator.isLocationServiceEnabled();

  @override
  Future<bool> openLocationSettings() => Geolocator.openLocationSettings();
}
