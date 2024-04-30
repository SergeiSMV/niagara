// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/features/location/domain/usecases/cities/get_city_use_case.dart';
import 'package:niagara_app/features/location/domain/usecases/permissions/get_user_position_use_case.dart';
import 'package:niagara_app/features/location/domain/usecases/permissions/open_settings_use_case.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

typedef MapState = ({Point point, bool finished});

@injectable
class MapCubit extends Cubit<MapState> {
  MapCubit({
    required OpenSettingsUseCase openSettingsUseCase,
    required LocationPermissionUseCase getUserLocationUseCase,
    required GetCityUseCase getCityUseCase,
  })  : _openSettingsUseCase = openSettingsUseCase,
        _getUserLocationUseCase = getUserLocationUseCase,
        _getCityUseCase = getCityUseCase,
        super(
          (
            point: Point(
              latitude: AppConst.kDefaultCity.latitude,
              longitude: AppConst.kDefaultCity.longitude,
            ),
            finished: false
          ),
        );

  late YandexMapController _controller;

  final OpenSettingsUseCase _openSettingsUseCase;
  final LocationPermissionUseCase _getUserLocationUseCase;
  final GetCityUseCase _getCityUseCase;

  bool isPermissionGranted = false;
  ScreenRect? focusRect;
  ({double x, double y})? markerPosition;

  static ({
    double latitude,
    double longitude,
  }) get defaultCity => AppConst.kDefaultCity;

  /// Отвечает за инициализацию контроллера карты
  Future<void> onControllerCreated(YandexMapController controller) async {
    _controller = controller;
    await determinePosition();
  }

  /// Отображает текущее местоположение пользователя
  Future<UserLocationView>? onUserLocationUpdated(
    UserLocationView view, {
    bool showUserPosition = true,
  }) async {
    /// Найти положение пользователя или установить дефолтное местоположение
    showUserPosition ? await _getUserPosition() : await _setDefaultLocation();

    return view.copyWith(
      pin: view.pin.copyWith(opacity: 0),
      arrow: view.arrow.copyWith(opacity: 0),
      accuracyCircle: view.accuracyCircle.copyWith(
        fillColor: view.accuracyCircle.fillColor.withOpacity(0.3),
        strokeColor: view.accuracyCircle.strokeColor.withOpacity(0.5),
        strokeWidth: 0.5,
      ),
    );
  }

  /// Отвечает за обновление адреса при изменении камеры/фокуса
  Future<void> onCameraPositionChanged(
    CameraPosition cameraPosition,
    CameraUpdateReason reason,
    bool finished,
    VisibleRegion visibleRegion,
  ) async {
    if (isClosed) return;

    final point = cameraPosition.target;

    /// Если фокус не задан, то устанавливаем его в относительных координатах
    if (focusRect == null) {
      final screenPoint = await _controller.getScreenPoint(point);

      focusRect = ScreenRect(
        topLeft: const ScreenPoint(x: 0, y: 0),
        bottomRight: ScreenPoint(x: screenPoint!.x * 2, y: screenPoint.y),
      );
    }

    /// Устанавливаем маркер в точку, где находится пользователь
    if (markerPosition == null) {
      final topLeft = visibleRegion.topLeft;
      final bottomRight = visibleRegion.bottomRight;

      final markerPositionX = (point.longitude - topLeft.longitude) /
          (bottomRight.longitude - topLeft.longitude);

      final markerPositionY = (topLeft.latitude - point.latitude) /
          (topLeft.latitude - bottomRight.latitude);

      markerPosition = (x: markerPositionX, y: markerPositionY);
    }
    final manualReaching = reason == CameraUpdateReason.gestures;

    /// Устанавливаем новую позицию
    if (isPermissionGranted) {
      emit(
        (
          point: point,
          finished: finished && manualReaching,
        ),
      );
    }
  }

  /// Определяет текущее местоположение пользователя и отображает его на карте
  Future<void> determinePosition() async {
    isPermissionGranted = await _checkUserLocationPermission();

    if (isPermissionGranted) {
      await _enableUserLayer();
      await _getUserPosition();
    } else {
      await _setDefaultLocation();
    }
  }

  /// Открывает настройки приложения
  Future<void> onOpenSettings() async => _openSettingsUseCase.call();

  /// Включает слой пользователя на карте
  Future<void> _enableUserLayer() async => _controller.toggleUserLayer(
        visible: true,
        autoZoomEnabled: true,
      );

  /// Получает текущее местоположение пользователя
  Future<void> _getUserPosition() async {
    if (isClosed) return;

    final point = await _controller.getUserCameraPosition();
    if (point != null) {
      await _moveCameraToPoint(point: point.target);
      emit((point: point.target, finished: true));
    }
  }

  // Устанавливает дефолтное местоположение
  Future<void> _setDefaultLocation() async {
    if (isClosed) return;

    final point = await _getCityUseCase.call().fold(
          (_) => Point(
            latitude: defaultCity.latitude,
            longitude: defaultCity.longitude,
          ),
          (city) => Point(
            latitude: city.coordinates.$1,
            longitude: city.coordinates.$2,
          ),
        );

    await _moveCameraToPoint(
      point: point,
      zoom: AppConst.kDefaultHighZoom,
    );
    emit((point: point, finished: true));
  }

  /// Перемещает камеру к указанной точке
  Future<void> _moveCameraToPoint({
    required Point point,
    double zoom = AppConst.kDefaultLowZoom,
  }) async {
    final target = Point(
      latitude: point.latitude,
      longitude: point.longitude,
    );

    await _controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: target,
          zoom: zoom,
        ),
      ),
      animation: const MapAnimation(),
    );
  }

  /// Проверяет разрешение на использование геолокации
  Future<bool> _checkUserLocationPermission() async =>
      _getUserLocationUseCase.call().fold(
            (failure) => false,
            (status) => status.isGranted,
          );
}
