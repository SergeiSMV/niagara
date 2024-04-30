import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/pages/map_yandex/cubit/map_cubit.dart';
import 'package:niagara_app/core/common/presentation/pages/map_yandex/widget/map_widget.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/location/domain/models/shop.dart';
import 'package:niagara_app/features/location/presentation/shops/widgets/cluster_icon_painted.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

class ShopsMapWidget extends StatelessWidget {
  const ShopsMapWidget({
    required this.shops,
    super.key,
  });

  static final _mapKey = GlobalKey();

  final List<Shop> shops;

  List<PlacemarkMapObject> get _getPlacemarkObjects => shops
      .map(
        (point) => PlacemarkMapObject(
          mapId: MapObjectId(point.id.toString()),
          point: Point(
            latitude: point.coordinates.$1,
            longitude: point.coordinates.$2,
          ),
          opacity: AppConst.kCommon1,
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage(
                Assets.images.niagaraPoint.path,
              ),
            ),
          ),
          onTap: (obj, point) {
            debugPrint('onTap: ${point.latitude}, ${point.longitude}');
          },
        ),
      )
      .toList();

  /// Метод для получения коллекции кластеризованных маркеров
  ClusterizedPlacemarkCollection _getClusterizedCollection(
    BuildContext context, {
    required List<PlacemarkMapObject> placemarks,
  }) =>
      ClusterizedPlacemarkCollection(
        mapId: const MapObjectId('clusterized-1'),
        placemarks: placemarks,
        radius: 50,
        minZoom: 15,
        onClusterAdded: (self, cluster) async => cluster.copyWith(
          appearance: cluster.appearance.copyWith(
            opacity: 1,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromBytes(
                  await ClusterIconPainter(cluster.size)
                      .getClusterIconBytes(context),
                ),
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final mapCubit = context.watch<MapCubit>();

    return BlocListener<MapCubit, MapState>(
      listener: (_, state) async {},
      child: LayoutBuilder(
        builder: (_, constraints) => MapWidget(
          key: _mapKey,
          mapObjects: [
            _getClusterizedCollection(
              context,
              placemarks: _getPlacemarkObjects,
            ),
          ],
          onControllerCreated: mapCubit.onControllerCreated,
          onUserLocationUpdated: (view) => mapCubit.onUserLocationUpdated(
            view,
            showUserPosition: false,
          ),
          onCameraPositionChanged: mapCubit.onCameraPositionChanged,
          focusRect: mapCubit.focusRect,
        ),
      ),
    );
  }
}
