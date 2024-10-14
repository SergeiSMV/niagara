// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/features/locations/addresses/domain/use_cases/permissions/check_gps_enabled_use_case.dart';
import 'package:niagara_app/features/locations/addresses/domain/use_cases/permissions/get_user_position_use_case.dart';
import 'package:niagara_app/features/locations/addresses/domain/use_cases/permissions/open_settings_use_case.dart';
import 'package:niagara_app/features/locations/cities/domain/use_cases/get_city_use_case.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

typedef MapState = ({Point point, bool finished});

@injectable
class MapCubit extends Cubit<MapState> {
  MapCubit({
    required OpenSettingsUseCase openSettingsUseCase,
    required LocationPermissionUseCase getUserLocationUseCase,
    required GetCityUseCase getCityUseCase,
    required CheckGpsEnabledUseCase checkGpsEnabledUseCase,
  })  : _openSettingsUseCase = openSettingsUseCase,
        _getUserLocationUseCase = getUserLocationUseCase,
        _getCityUseCase = getCityUseCase,
        _checkGpsEnabledUseCase = checkGpsEnabledUseCase,
        super(
          (
            point: Point(
              latitude: AppConstants.kDefaultCity.$1,
              longitude: AppConstants.kDefaultCity.$2,
            ),
            finished: false
          ),
        );

  late YandexMapController _controller;

  final OpenSettingsUseCase _openSettingsUseCase;
  final LocationPermissionUseCase _getUserLocationUseCase;
  final CheckGpsEnabledUseCase _checkGpsEnabledUseCase;
  final GetCityUseCase _getCityUseCase;

  bool isPermissionGranted = false;
  bool isGpsEnabled = false;

  /// Отвечает за инициализацию контроллера карты
  Future<void> onControllerCreated(YandexMapController controller) async {
    _controller = controller;
    await determinePosition();
  }

  /// Отображает текущее местоположение пользователя
  Future<UserLocationView>? onUserLocationUpdated(UserLocationView view) async {
    final pin = view.pin;
    final arrow = view.arrow;
    final accuracy = view.accuracyCircle;

    return view.copyWith(
      pin: pin.copyWith(opacity: 0),
      arrow: arrow.copyWith(opacity: 0),
      accuracyCircle: accuracy.copyWith(
        fillColor: accuracy.fillColor.withOpacity(.3),
        strokeColor: accuracy.strokeColor.withOpacity(.5),
        strokeWidth: .5,
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
    isGpsEnabled = await _checkGpsEnabled();

    if (isPermissionGranted && isGpsEnabled) {
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
            latitude: AppConstants.kDefaultCity.$1,
            longitude: AppConstants.kDefaultCity.$2,
          ),
          (city) => Point(
            latitude: city.coordinates.$1,
            longitude: city.coordinates.$2,
          ),
        );

    await moveCameraToPoint(
      point: point,
      zoom: AppConstants.kDefaultHighZoom,
    );
    _emit((point: point, finished: true));
  }

  /// Перемещает камеру к указанной точке
  Future<void> moveCameraToPoint({
    required Point point,
    double zoom = AppConstants.kDefaultLowZoom,
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

  /// Проверяет включен ли GPS на устройстве
  Future<bool> _checkGpsEnabled() => _checkGpsEnabledUseCase.call().fold(
        (failure) => false,
        (enabled) => enabled,
      );

  void _emit(MapState state) {
    if (isClosed) return;
    emit(state);
  }
}
