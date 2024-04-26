import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/map_widget.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/location/presentation/adding_address/choice_on_map/cubit/choice_on_map_cubit.dart';

class ChoiceOnMapMapWidget extends StatelessWidget {
  const ChoiceOnMapMapWidget({super.key});

  static const _markerSize = AppConst.kIconLarge;

  static final _mapKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ChoiceOnMapCubit>();
    final markerPosition = cubit.markerPosition;

    return LayoutBuilder(
      builder: (_, constraints) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          MapWidget(
            key: _mapKey,
            mapObjects: const [],
            onControllerCreated: cubit.onControllerCreated,
            onUserLocationUpdated: cubit.onUserLocationUpdated,
            onCameraPositionChanged: cubit.onCameraPositionChanged,
            focusRect: cubit.focusRect,
            allowUserInteractions: cubit.isPermissionGranted,
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
          // ! Никакой рекламы Яндекса! 😈
          SizedBox(
            width: double.infinity,
            height: AppConst.kCommon24,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.colors.mainColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
