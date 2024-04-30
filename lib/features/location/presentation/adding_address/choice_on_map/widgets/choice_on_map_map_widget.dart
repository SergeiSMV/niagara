import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/pages/map_yandex/cubit/map_cubit.dart';
import 'package:niagara_app/core/common/presentation/pages/map_yandex/widget/map_widget.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/location/presentation/adding_address/choice_on_map/cubit/choice_on_map_cubit.dart';

class ChoiceOnMapMapWidget extends StatelessWidget {
  const ChoiceOnMapMapWidget({super.key});

  static const _markerSize = AppConst.kIconLarge;

  static final _mapKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final choiceOnMapCubit = context.read<ChoiceOnMapCubit>();
    final mapCubit = context.watch<MapCubit>();
    final markerPosition = mapCubit.markerPosition;

    return BlocListener<MapCubit, MapState>(
      listener: (_, state) async {
        await choiceOnMapCubit.searchAddress(
          point: state.point,
          finished: state.finished,
        );
      },
      child: LayoutBuilder(
        builder: (_, constraints) => Stack(
          alignment: Alignment.bottomCenter,
          children: [
            MapWidget(
              key: _mapKey,
              mapObjects: const [],
              onControllerCreated: mapCubit.onControllerCreated,
              onUserLocationUpdated: mapCubit.onUserLocationUpdated,
              onCameraPositionChanged: mapCubit.onCameraPositionChanged,
              focusRect: mapCubit.focusRect,
              allowUserInteractions: mapCubit.isPermissionGranted,
            ),
            if (markerPosition != null)
              Positioned(
                left: markerPosition.x * constraints.maxWidth -
                    _markerSize / AppConst.kCommon2,
                top: markerPosition.y * constraints.maxHeight - _markerSize,
                child: Assets.images.currentLocation.image(
                  width: _markerSize,
                  height: _markerSize,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
