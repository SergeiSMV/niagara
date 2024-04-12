import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Сервис для определения местоположения.
abstract interface class IGeolocatorService {
  /// Определение положения
  Future<Position?> determinePosition({
    bool useLastKnownPosition = false,
  });

  /// Запрос разрешения на использование местоположения
  Future<bool> isPermission();
}

@LazySingleton(as: IGeolocatorService)
class GeolocatorServiceDefault implements IGeolocatorService {
  GeolocatorServiceDefault({
    required IAppLogger logger,
  }) : _logger = logger;

  final IAppLogger _logger;

  @override
  Future<Position?> determinePosition({
    bool useLastKnownPosition = false,
  }) async {
    try {
      if (await isPermission()) {
        // Использование последнего определённого положения
        if (useLastKnownPosition) {
          final lastKnownPosition = await Geolocator.getLastKnownPosition();
          if (lastKnownPosition != null) return lastKnownPosition;
        }

        // Использование текущего положения
        return await Geolocator.getCurrentPosition();
      }
      return null;
    } on Exception catch (e, st) {
      _logger.handle(e, st);
      return null;
    }
  }

  @override
  Future<bool> isPermission() async {
    try {
      await isServiceEnabled();
      await checkPermission();
      return true;
    } on Exception catch (e, st) {
      _logger.handle(e, st);
      return false;
    }
  }

  Future<bool> checkPermission() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _logger.log(
          level: LogLevel.warning,
          message: 'GeolocatorServiceDefault :: Permission denied',
        );
        throw const PermissionDeniedException('');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _logger.log(
        level: LogLevel.warning,
        message: 'GeolocatorServiceDefault :: Permission denied forever',
      );
      throw const PermissionDeniedForeverException();
    }

    return true;
  }

  Future<bool> isServiceEnabled() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _logger.log(
        level: LogLevel.warning,
        message: 'GeolocatorServiceDefault :: Service is not enabled',
      );
      throw const ServiceNotEnabledException();
    }

    return true;
  }
}
