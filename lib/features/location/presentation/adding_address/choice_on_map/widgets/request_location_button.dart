import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/location/presentation/adding_address/choice_on_map/cubit/choice_on_map_cubit.dart';

class RequestLocationButton extends StatelessWidget {
  const RequestLocationButton({super.key});

  Future<void> onDeterminePosition(BuildContext context) async {
    final cubit = context.read<ChoiceOnMapCubit>();
    await cubit.determinePosition().whenComplete(() {
      if (!cubit.isPermissionGranted) showDialog(context);
    });
  }

  Future<void> showDialog(BuildContext context) async {
    final cubit = context.read<ChoiceOnMapCubit>();
    final textStyle = context.textStyle.buttonTypo.btn2semiBold
        .withColor(context.colors.textColors.accent);

    return showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: Text(t.locations.turnOnLocation),
        content: Text(t.locations.turnOnLocationDescription),
        actions: [
          TextButton(
            onPressed: () => context.maybePop(),
            child: Text(t.locations.later, style: textStyle),
          ),
          TextButton(
            onPressed: () {
              context.maybePop();
              cubit.onOpenSettings();
            },
            child: Text(t.locations.settings, style: textStyle),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onDeterminePosition(context),
      child: Assets.icons.location
          .svg(width: AppConst.kIconLarge, height: AppConst.kIconLarge)
          .paddingSymmetric(horizontal: AppConst.kCommon16),
    );
  }
}
