part of '../../core.dart';

@lazySingleton
class PermissionsService {
  /// Открывает настройки приложения.
  Future<bool> openSettings() async => openAppSettings();

  /// Проверяет, есть ли у приложения разрешение на использование геолокации.
  Future<bool> checkLocationPermission() async =>
      Permission.location.request().isGranted;
}
