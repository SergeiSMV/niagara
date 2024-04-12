import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/location/presentation/cubit/map_cubit.dart';
import 'package:niagara_app/features/location/presentation/widgets/map_widget.dart';

@RoutePage()
class AddressSelectionPage extends StatelessWidget {
  const AddressSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mapCubit = context.read<MapCubit>();
    return Scaffold(
      appBar: AppBarWidget(
        title: t.locations.deliveryAddress,
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: mapCubit.determinePosition,
            child: Assets.icons.location
                .svg(width: AppConst.kIconLarge, height: AppConst.kIconLarge)
                .paddingSymmetric(horizontal: AppConst.kPaddingMax),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 3,
                child: BlocBuilder<MapCubit, MapState>(
                  builder: (context, state) => MapWidget(
                    mapObjects: const [],
                    onControllerCreated: mapCubit.onControllerCreated,
                    onUserLocationUpdated: (view) =>
                        mapCubit.onUserView(context, view),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          Column(
            children: [
              const Spacer(flex: 2),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: context.colors.mainColors.white,
                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(AppConst.kPaddingExtra),
                    //   topRight: Radius.circular(AppConst.kPaddingExtra),
                    // ),
                    boxShadow: [
                      BoxShadow(
                        color: context.colors.textColors.main.withOpacity(0.08),
                        blurRadius: AppConst.kShadowBlur,
                        offset: AppConst.kShadowOffset,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
