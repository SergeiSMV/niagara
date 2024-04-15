part of '../../core.dart';

@lazySingleton
class PermissionsService {
  /// Проверяет, есть ли у приложения разрешение на использование геолокации.
  Future<bool> checkLocationPermission() async =>
      Permission.location.request().isGranted;
}
