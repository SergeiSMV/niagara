import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
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
    return InkWell(
      onTap: () => _navigateToLocations(context),
      child: BlocBuilder<AddressesBloc, AddressesState>(
        buildWhen: (previous, current) =>
            previous.locationName != current.locationName,
        builder: (_, state) => state.maybeWhen(
          loading: () => Align(
            alignment: Alignment.centerLeft,
            child: Assets.lottie.loadCircle.lottie(
              repeat: true,
              width: AppConst.kLoaderSmall,
              height: AppConst.kLoaderSmall,
            ),
          ),
          loaded: (_, __) => _buildLocationName(
            context,
            name: state.locationName,
          ),
          unauthorized: (_) => _buildLocationName(
            context,
            name: state.locationName,
          ),
          orElse: SizedBox.shrink,
        ),
      ),
    );
  }

  Row _buildLocationName(
    BuildContext context, {
    required String name,
  }) {
    final textStyle = context.textStyle.textTypo.tx2SemiBold;
    final mainColor = context.colors.textColors.main;
    return Row(
      children: [
        Flexible(
          child: Text(
            name,
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
    );
  }
}
