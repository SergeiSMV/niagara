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
  /// Флаг, который отвечает за то, чтобы не запрашивать разрешение на
  /// использование геолокации несколько раз подряд.
  bool _isRequestingPermission = false;

  @override
  Future<bool> openSettings() async => openAppSettings();

  @override
  Future<PermissionStatus> checkLocationPermission() async {
    /// Если разрешение уже запрашивается, то возвращаем текущий статус.
    if (_isRequestingPermission) {
      return await Permission.location.status;
    }

    try {
      _isRequestingPermission = true;
      final status = await Permission.location.status;

      /// Если разрешение отклонено, то запрашиваем его.
      if (status == PermissionStatus.denied) {
        return await Permission.location.request();
      }

      return status;
    } finally {
      /// Снимаем флаг, что разрешение запрашивается.
      _isRequestingPermission = false;
    }
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
