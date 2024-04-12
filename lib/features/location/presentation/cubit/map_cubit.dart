import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/services/geolocator_service.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

part 'map_cubit.freezed.dart';
part 'map_state.dart';

@lazySingleton
class MapCubit extends Cubit<MapState> {
  MapCubit({
    required IGeolocatorService geolocatorService,
  })  : _geolocatorService = geolocatorService,
        super(const MapState.initial());

  late YandexMapController _controller;

  final IGeolocatorService _geolocatorService;

  @disposeMethod
  @override
  Future<void> close() {
    _controller.dispose();
    return super.close();
  }

  Future<void> onControllerCreated(YandexMapController controller) async {
    _controller = controller;
    final position = await _geolocatorService.determinePosition();
    final isPositionAvailable = position != null;

    await _controller.toggleUserLayer(
      visible: isPositionAvailable,
      autoZoomEnabled: true,
    );

    final latitude = isPositionAvailable
        ? position.latitude
        : AppConst.kDefaultCity.latitude;

    final longitude = isPositionAvailable
        ? position.longitude
        : AppConst.kDefaultCity.longitude;

    final point = Point(latitude: latitude, longitude: longitude);

    await _controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: point,
        ),
      ),
    );
  }

  Future<void> determinePosition() async {
    final isPermission = await _geolocatorService.isPermission();
    debugPrint('isPermission: $isPermission');
  }

  Future<void> onUserLocationUpdated(UserLocationView userLocation) async {}

  Future<void> onMapTap(Point point) async {}

  Future<UserLocationView>? onUserView(
    BuildContext context,
    UserLocationView view,
  ) async {
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
        fillColor: context.colors.mainColors.primary.withOpacity(0.7),
        strokeColor: context.colors.mainColors.primary.withOpacity(0.16),
        strokeWidth: view.accuracyCircle.strokeWidth * 10,
      ),
    );
  }
}
