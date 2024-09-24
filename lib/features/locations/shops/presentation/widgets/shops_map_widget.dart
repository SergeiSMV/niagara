import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/locations/_common/presentation/pages/map_yandex/cubit/map_cubit.dart';
import 'package:niagara_app/features/locations/_common/presentation/pages/map_yandex/widget/map_widget.dart';
import 'package:niagara_app/features/locations/shops/domain/models/shop.dart';
import 'package:niagara_app/features/locations/shops/presentation/bloc/shops_bloc.dart';
import 'package:niagara_app/features/locations/shops/presentation/widgets/cluster_icon_painted.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

class ShopsMapWidget extends StatelessWidget {
  const ShopsMapWidget({super.key});

  static final _mapKey = GlobalKey();

  void _onTap(BuildContext context, Shop shop) {
    final mapCubit = context.read<MapCubit>();
    final shopsBloc = context.read<ShopsBloc>();
    final point = Point(
      latitude: shop.coordinates.$1,
      longitude: shop.coordinates.$2,
    );

    mapCubit
        .moveCameraToPoint(point: point)
        .whenComplete(() => shopsBloc.add(ShopsEvent.selectShop(shop: shop)));
  }

  /// Метод для получения коллекции кластеризованных маркеров
  ClusterizedPlacemarkCollection _getClusterizedCollection(
    BuildContext context, {
    required List<Shop> shops,
  }) {
    final getPlacemarkObjects = shops
        .map(
          (shop) => PlacemarkMapObject(
            mapId: MapObjectId(shop.id.toString()),
            point: Point(
              latitude: shop.coordinates.$1,
              longitude: shop.coordinates.$2,
            ),
            opacity: AppSizes.kGeneral1,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage(
                  Assets.images.niagaraPoint.path,
                ),
              ),
            ),
            onTap: (_, __) => _onTap(context, shop),
          ),
        )
        .toList();

    return ClusterizedPlacemarkCollection(
      mapId: MapObjectId('cluster_${shops.length}'),
      placemarks: getPlacemarkObjects,
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
  }

  @override
  Widget build(BuildContext context) {
    final mapCubit = context.watch<MapCubit>();
    final shopsBloc = context.read<ShopsBloc>();
    final shops = shopsBloc.state.shops;

    return Column(
      children: [
        Expanded(
          flex: AppSizes.kGeneral32.toInt(),
          child: MapWidget(
            key: _mapKey,
            mapObjects: [
              _getClusterizedCollection(context, shops: shops),
            ],
            onControllerCreated: mapCubit.onControllerCreated,
            onUserLocationUpdated: (view) {
              mapCubit.setDefaultLocation();
              return mapCubit.onUserLocationUpdated(view);
            },
            onCameraPositionChanged: mapCubit.onCameraPositionChanged,
          ),
        ),
        Spacer(flex: AppSizes.kGeneral2.toInt()),
      ],
    );
  }
}
