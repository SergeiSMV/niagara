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
  Future<UserLocationView>? onUserLocationUpdated(UserLocationView view) async {
    /// Найти положение пользователя или установить дефолтное местоположение
    // showUserPosition ? await getUserPosition() : await setDefaultLocation();

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
    final point = cameraPosition.target;
    final manualReaching = reason == CameraUpdateReason.gestures;

    if (isPermissionGranted && manualReaching) {
      _emit((point: point, finished: finished));
    }
  }

  /// Определяет текущее местоположение пользователя и отображает его на карте
  Future<void> determinePosition() async {
    isPermissionGranted = await _checkUserLocationPermission();

    if (isPermissionGranted) {
      await _enableUserLayer();
      await getUserPosition();
    } else {
      await setDefaultLocation();
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
  Future<void> getUserPosition() async {
    final point = await _controller.getUserCameraPosition();
    if (point != null) {
      await moveCameraToPoint(point: point.target);
      _emit((point: point.target, finished: true));
    }
  }

  // Устанавливает дефолтное местоположение
  Future<void> setDefaultLocation() async {
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

    await moveCameraToPoint(
      point: point,
      zoom: AppConst.kDefaultHighZoom,
    );
    _emit((point: point, finished: true));
  }

  /// Перемещает камеру к указанной точке
  Future<void> moveCameraToPoint({
    required Point point,
    double zoom = AppConst.kDefaultLowZoom,
  }) async {
    _emit((point: point, finished: false));

    await _controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: point,
          zoom: zoom,
        ),
      ),
      animation: const MapAnimation(),
    );

    _emit((point: point, finished: true));
  }

  /// Проверяет разрешение на использование геолокации
  Future<bool> _checkUserLocationPermission() async =>
      _getUserLocationUseCase.call().fold(
            (failure) => false,
            (status) => status.isGranted,
          );

  void _emit(MapState state) {
    if (isClosed) return;
    emit(state);
  }
}
