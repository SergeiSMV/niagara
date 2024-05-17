import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/locations/_common/presentation/pages/map_yandex/cubit/map_cubit.dart';
import 'package:niagara_app/features/locations/_common/presentation/pages/map_yandex/widget/map_widget.dart';
import 'package:niagara_app/features/locations/addresses/presentation/adding_address/choice_on_map/cubit/choice_on_map_cubit.dart';

class ChoiceOnMapMapWidget extends StatelessWidget {
  const ChoiceOnMapMapWidget({super.key});

  static const _markerSize = AppSizes.kIconLarge;

  static final _mapKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final choiceOnMapCubit = context.read<ChoiceOnMapCubit>();
    final mapCubit = context.watch<MapCubit>();

    return BlocListener<MapCubit, MapState>(
      listener: (_, state) async {
        await choiceOnMapCubit.searchAddress(
          point: state.point,
          finished: state.finished,
        );
      },
      child: Column(
        children: [
          Expanded(
            flex: AppSizes.kGeneral32.toInt(),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                MapWidget(
                  key: _mapKey,
                  mapObjects: const [],
                  onControllerCreated: mapCubit.onControllerCreated,
                  onUserLocationUpdated: (view) {
                    mapCubit.getUserPosition();
                    return mapCubit.onUserLocationUpdated(view);
                  },
                  onCameraPositionChanged: mapCubit.onCameraPositionChanged,
                  allowUserInteractions: mapCubit.isPermissionGranted,
                ),
                Center(
                  child: Assets.images.currentLocation.image(
                    width: _markerSize,
                    height: _markerSize,
                  ),
                ),
              ],
            ),
          ),
          Spacer(flex: AppSizes.kGeneral2.toInt()),
        ],
      ),
    );
  }
}
