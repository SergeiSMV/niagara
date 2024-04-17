import 'dart:async';
import 'dart:math';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/common/presentation/theme/app_colors.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/location/domain/usecases/get_address.dart';
import 'package:niagara_app/features/location/domain/usecases/get_user_position.dart';
import 'package:niagara_app/features/location/domain/usecases/open_settings.dart';
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

  final GlobalKey mapKey = GlobalKey();
  final GlobalKey modalKey = GlobalKey();

  @disposeMethod
  @override
  Future<void> close() {
    return super.close();
  }

  Future<void> onControllerCreated(YandexMapController controller) async {
    _controller = controller;
    await determinePosition();
  }

  Future<UserLocationView>? onUserLocationUpdated(UserLocationView view) async {
    final color = const AppColors().mainColors.primary;

    emit(const _Searching());

    final point = await _getUserPosition();
    if (point != null) {
      await _getAddressUseCase.call(point).fold(
            (failure) => null,
            (address) => emit(_Complete(address: address)),
          );
    }

    return view.copyWith(
      pin: view.pin.copyWith(
        opacity: 1,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(
              Assets.images.userIndicator.path,
            ),
          ),
        ),
      ),
      arrow: view.arrow.copyWith(opacity: 0),
      accuracyCircle: view.accuracyCircle.copyWith(
        fillColor: color.withOpacity(0.7),
        strokeColor: color.withOpacity(0.16),
        strokeWidth: view.accuracyCircle.strokeWidth * 10,
      ),
    );
  }

  Future<bool> determinePosition() async {
    final isPermissionGranted = await checkUserLocationPermission();

    if (isPermissionGranted) {
      await enableUserLayer();
      await _getUserPosition();
    } else {
      await _setDefaultLocation();
    }

    return isPermissionGranted;
  }

  Future<bool> checkUserLocationPermission() async =>
      _getUserLocationUseCase.call().fold(
            (failure) => false,
            (status) => status.isGranted,
          );

  Future<void> enableUserLayer() async => _controller.toggleUserLayer(
        visible: true,
        autoZoomEnabled: true,
      );

  Future<void> onOpenSettings() async => _openSettingsUseCase.call();

  Future<void> onApproveAddress() async {
    final state = this.state as _Complete;
    emit(_Approve(address: state.address));
    await _getUserPosition();
  }

  Future<void> onEnterFlat(String? flat) async {
    await _updateState(flat: flat);
  }

  Future<void> onEnterEntrance(String? entrance) async {
    await _updateState(entrance: entrance);
  }

  Future<void> onEnterFloor(String? floor) async {
    await _updateState(floor: floor);
  }

  Future<void> onEnterComment(String? comment) async {
    await _updateState(comment: comment);
  }

  Future<Point?> _getUserPosition() async {
    final point = await _controller.getUserCameraPosition();
    if (point != null) {
      await _moveCameraToPoint(point: point.target);
      return point.target;
    }
    return null;
  }

  Future<void> _moveCameraToPoint({
    required Point point,
    double zoom = AppConst.kDefaultZoom,
  }) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final mapSize = mapKey.currentContext?.size;
      final completeModalSize =
          modalKey.currentContext?.findRenderObject() as RenderBox?;
      final completeHeight = completeModalSize?.size.height;

      if (mapSize != null && completeHeight != null) {
        final halfModalHeight = completeHeight / 2;
        final relativeHeight = halfModalHeight / mapSize.height;
        final offset =
            pow(2, AppConst.kDefaultZoom - zoom) * relativeHeight / 100;

        final target = Point(
          latitude: point.latitude - offset,
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
    });
  }

  Future<void> _updateState({
    String? flat,
    String? entrance,
    String? floor,
    String? comment,
  }) async {
    final approveState = state as _Approve;
    emit(
      _Approve(
        address: approveState.address,
        flat: flat ?? approveState.flat,
        entrance: entrance ?? approveState.entrance,
        floor: floor ?? approveState.floor,
        comment: comment ?? approveState.comment,
      ),
    );
  }

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
