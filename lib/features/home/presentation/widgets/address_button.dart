import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/location/presentation/locations/bloc/locations_bloc.dart';

/// Кнопка в AppBar для отображения адреса доставки. При нажатии на кнопку
/// должен открываться экран с выбором адреса доставки.
class AppBarAddressButton extends StatelessWidget {
  const AppBarAddressButton({super.key});

  void _navigateToLocations(BuildContext context) {
    context.pushRoute(
      const LocationsNavigatorRoute(
        children: [
          LocationsWrapperRoute(
            children: [
              LocationsRoute(),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = context.textStyle.textTypo.tx2SemiBold;
    final mainColor = context.colors.textColors.main;
    return InkWell(
      onTap: () => _navigateToLocations(context),
      child: BlocProvider.value(
        value: getIt<LocationsBloc>(),
        child: BlocBuilder<LocationsBloc, LocationsState>(
          builder: (_, state) => state.maybeWhen(
            loaded: (_, __) => Row(
              children: [
                Flexible(
                  child: Text(
                    state.locationName,
                    style: textStyle.withColor(mainColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                AppConst.kCommon4.horizontalBox,
                Assets.icons.arrowRight.svg(
                  width: AppConst.kIconSmall,
                  height: AppConst.kIconSmall,
                  colorFilter: ColorFilter.mode(mainColor, BlendMode.srcIn),
                ),
              ],
            ),
            orElse: () => Assets.lottie.loadCircle.lottie(
              repeat: true,
              width: AppConst.kLoaderSmall,
              height: AppConst.kLoaderSmall,
            ),
          ),
        ),
      ),
    );
  }
}
