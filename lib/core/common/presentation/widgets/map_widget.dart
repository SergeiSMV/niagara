import 'package:flutter/material.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

/// Виджет карты Яндекса с возможностью добавления объектов на карту
class MapWidget extends StatelessWidget {
  const MapWidget({
    required this.mapObjects,
    this.onControllerCreated,
    this.onUserLocationUpdated,
    this.onCameraPositionChanged,
    this.allowUserInteractions = true,
    super.key,
  });

  /// Список объектов на карте
  final List<MapObject<dynamic>> mapObjects;

  /// Callback при создании контроллера карты
  final MapCreatedCallback? onControllerCreated;

  /// Callback при обновлении местоположения пользователя
  final UserLocationCallback? onUserLocationUpdated;

  /// Callback при изменении позиции камеры
  final CameraPositionCallback? onCameraPositionChanged;

  /// Разрешить ли пользовательские взаимодействия с картой
  final bool allowUserInteractions;

  @override
  Widget build(BuildContext context) {
    return YandexMap(
      tiltGesturesEnabled: allowUserInteractions,
      rotateGesturesEnabled: false,
      scrollGesturesEnabled: allowUserInteractions,
      zoomGesturesEnabled: allowUserInteractions,
      fastTapEnabled: true,
      onMapCreated: onControllerCreated,
      mapObjects: mapObjects,
      onUserLocationAdded: onUserLocationUpdated,
      onCameraPositionChanged: onCameraPositionChanged,
    );
  }
}
