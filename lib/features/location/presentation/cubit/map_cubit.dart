import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/common/presentation/theme/app_colors.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/location/domain/usecases/get_address.dart';
import 'package:niagara_app/features/location/domain/usecases/get_user_position.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

part 'map_cubit.freezed.dart';
part 'map_state.dart';

@lazySingleton
class MapCubit extends Cubit<MapState> {
  MapCubit({
    required LocationPermissionUseCase getUserLocationUseCase,
    required GetAddressUseCase getAddressUseCase,
  })  : _getUserLocationUseCase = getUserLocationUseCase,
        _getAddressUseCase = getAddressUseCase,
        super(const _MapInitialState());

  late YandexMapController _controller;

  final LocationPermissionUseCase _getUserLocationUseCase;
  final GetAddressUseCase _getAddressUseCase;

  final GlobalKey mapKey = GlobalKey();
  final GlobalKey modalKey = GlobalKey();

  @disposeMethod
  @override
  Future<void> close() {
    _controller.dispose();
    return super.close();
  }

  Future<void> onControllerCreated(YandexMapController controller) async {
    emit(const _MapSearchingState());

    _controller = controller;

    final isGranted = await _getUserLocationUseCase.call().fold(
          (failure) => false,
          (isGranted) => isGranted,
        );

    if (isGranted) {
      await _controller.toggleUserLayer(
        visible: true,
        autoZoomEnabled: true,
      );
    } else {}
  }

  Future<void> determinePosition() async {}

  Future<UserLocationView>? onUserLocationUpdated(UserLocationView view) async {
    final color = const AppColors().mainColors.primary;

    final userPoint = await _moveCameraToUserLocation();

    if (userPoint != null) {
      await _getAddressUseCase.call(userPoint).fold(
            (failure) => null,
            (address) => emit(_MapCompleteState(address: address)),
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

  Future<void> approveAddress({required String address}) async {
    emit(_MapApproveState(address: address));

    await _moveCameraToUserLocation();
  }

  Future<Point?> _moveCameraToUserLocation() async {
    final userLocation = await _controller.getUserCameraPosition();
    if (userLocation == null) return null;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final mapSize = mapKey.currentContext?.size;
      final completeModalSize =
          modalKey.currentContext?.findRenderObject() as RenderBox?;
      final completeHeight = completeModalSize?.size.height;

      if (mapSize != null && completeHeight != null) {
        final halfModalHeight = completeHeight / 2;
        final relativeHeight = halfModalHeight / mapSize.height;
        final percentageOffset = relativeHeight / 100;

        final target = Point(
          latitude: userLocation.target.latitude - percentageOffset,
          longitude: userLocation.target.longitude,
        );

        await _controller.moveCamera(
          CameraUpdate.newCameraPosition(
            userLocation.copyWith(
              target: target,
              zoom: 16,
            ),
          ),
          animation: const MapAnimation(),
        );
      }
    });

    return userLocation.target;
  }
}
