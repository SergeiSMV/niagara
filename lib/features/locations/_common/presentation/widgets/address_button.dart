import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/locations/addresses/presentation/addresses/bloc/addresses_bloc.dart';

/// Кнопка в AppBar для отображения адреса доставки. При нажатии на кнопку
/// должен открываться экран с выбором адреса доставки.
class AddressButton extends StatelessWidget {
  const AddressButton({super.key});

  void _navigateToLocations(BuildContext context) => context.pushRoute(
        const LocationsWrapper(
          children: [
            LocationsTabRoute(children: [AddressesRoute()]),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final textStyle = context.textStyle.textTypo.tx2SemiBold;
    final mainColor = context.colors.textColors.main;

    final addressState = context.watch<AddressesBloc>().state;
    final locationName = addressState.locationName;

    return InkWell(
      onTap: () => _navigateToLocations(context),
      child: locationName.isNotEmpty
          ? Row(
              children: [
                Flexible(
                  child: Text(
                    locationName,
                    style: textStyle.withColor(mainColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                AppBoxes.kBoxH4,
                Assets.icons.arrowRight.svg(
                  width: AppSizes.kIconSmall,
                  height: AppSizes.kIconSmall,
                  colorFilter: ColorFilter.mode(mainColor, BlendMode.srcIn),
                ),
              ],
            )
          : Align(
              alignment: Alignment.centerLeft,
              child: Assets.lottie.loadCircle.lottie(
                repeat: true,
                width: AppSizes.kLoaderSmall,
                height: AppSizes.kLoaderSmall,
              ),
            ),
    );
  }
}
