// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/features/location/domain/entities/location.dart';
import 'package:niagara_app/features/location/domain/usecases/get_address_use_case.dart';
import 'package:niagara_app/features/location/domain/usecases/get_user_position_use_case.dart';
import 'package:niagara_app/features/location/domain/usecases/open_settings_use_case.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

part 'address_selection_cubit.freezed.dart';
part 'address_selection_state.dart';

@lazySingleton
class AddressSelectionCubit extends Cubit<AddressSelectionState> {
  AddressSelectionCubit({
    required OpenSettingsUseCase openSettingsUseCase,
    required LocationPermissionUseCase getUserLocationUseCase,
    required GetAddressUseCase getAddressUseCase,
  })  : _openSettingsUseCase = openSettingsUseCase,
        _getUserLocationUseCase = getUserLocationUseCase,
        _getAddressUseCase = getAddressUseCase,
        super(const _Initial());

  late YandexMapController _controller;

  final OpenSettingsUseCase _openSettingsUseCase;
  final LocationPermissionUseCase _getUserLocationUseCase;
  final GetAddressUseCase _getAddressUseCase;

  bool isPermissionGranted = false;

  ScreenRect? focusRect;
  ({double x, double y})? markerPosition;

  @disposeMethod
  @override
  Future<void> close() {
    return super.close();
  }

  // Отвечает за инициализацию контроллера карты
  Future<void> onControllerCreated(YandexMapController controller) async {
    _controller = controller;
    await determinePosition();
  }

  /// Отображает текущее местоположение пользователя
  Future<UserLocationView>? onUserLocationUpdated(UserLocationView view) async {
    await _getUserPosition();
    await _getAddress();

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
    emit(const _Searching());

    final point = cameraPosition.target;

    // Если фокус не задан, то устанавливаем его в относительных координатах
    if (focusRect == null) {
      final screenPoint = await _controller.getScreenPoint(point);

      focusRect = ScreenRect(
        topLeft: const ScreenPoint(x: 0, y: 0),
        bottomRight: ScreenPoint(x: screenPoint!.x * 2, y: screenPoint.y),
      );
    }

    // Устанавливаем маркер в точку, где находится пользователь
    if (markerPosition == null) {
      final topLeft = visibleRegion.topLeft;
      final bottomRight = visibleRegion.bottomRight;

      final markerPositionX = (point.longitude - topLeft.longitude) /
          (bottomRight.longitude - topLeft.longitude);

      final markerPositionY = (topLeft.latitude - point.latitude) /
          (topLeft.latitude - bottomRight.latitude);

      markerPosition = (x: markerPositionX, y: markerPositionY);
    }

    // Если камера остановилась, то получаем адрес
    if (finished && isPermissionGranted) {
      await _getAddress();
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

  /// Подтверждает адрес и переходит на экран редактирования
  Future<void> onApproveAddress() async {
    final state = this.state as _Complete;
    emit(_Approve(location: state.location));
  }

  /// Переходит на экран редактирования адреса
  Future<void> onEditAddress() async {
    final state = this.state as _Approve;
    emit(_Complete(location: state.location));
  }

  /// Обновляет дополнительные данные адреса
  Future<void> updateAdditionalAddressData({
    String? flat,
    String? entrance,
    String? floor,
    String? comment,
  }) async {
    final location = (state as _Approve).location;
    emit(
      _Approve(
        location: location.copyWith(
          address: location.address.copyWith(
            flat: flat,
            entrance: entrance,
            floor: floor,
          ),
          comment: comment,
        ),
      ),
    );
  }

  // Проверяет разрешение на использование геолокации
  Future<bool> _checkUserLocationPermission() async =>
      _getUserLocationUseCase.call().fold(
            (failure) => false,
            (status) => status.isGranted,
          );

  // Включает слой пользователя на карте
  Future<void> _enableUserLayer() async => _controller.toggleUserLayer(
        visible: true,
        autoZoomEnabled: true,
      );

  // Получает адрес по координатам
  Future<void> _getAddress() async {
    final point = await _controller.getCameraPosition();
    await _getAddressUseCase.call(point.target).fold(
          (_) => emit(const _NoAddressFound()),
          (location) => emit(_Complete(location: location)),
        );
  }

  // Получает текущее местоположение пользователя
  Future<Point?> _getUserPosition() async {
    final point = await _controller.getUserCameraPosition();
    if (point != null) {
      await _moveCameraToPoint(point: point.target);
      return point.target;
    }
    return null;
  }

  // Перемещает камеру к указанной точке
  Future<void> _moveCameraToPoint({
    required Point point,
    double zoom = AppConst.kDefaultZoom,
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

  // Устанавливает дефолтное местоположение
  Future<void> _setDefaultLocation() async {
    const defaultCity = AppConst.kDefaultCity;
    final point = Point(
      latitude: defaultCity.latitude,
      longitude: defaultCity.longitude,
    );
    await _moveCameraToPoint(
      point: point,
      zoom: 10,
    );
    emit(const _Denied());
  }
}
