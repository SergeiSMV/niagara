import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/location/presentation/cubit/address_selection_cubit.dart';

class LocationUnavailableWidget extends StatelessWidget {
  const LocationUnavailableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressSelectionCubit, AddressSelectionState>(
      buildWhen: (previous, current) => previous != current,
      builder: (_, state) => state.maybeWhen(
        denied: () => Container(
          padding: const EdgeInsets.all(AppConst.kCommon12),
          decoration: BoxDecoration(
            color: context.colors.infoColors.bgRed,
            borderRadius: BorderRadius.circular(AppConst.kCommon12),
          ),
          child: Row(
            children: [
              Assets.icons.closeFilling.svg(
                colorFilter: ColorFilter.mode(
                  context.colors.fieldBordersColors.negative,
                  BlendMode.srcIn,
                ),
              ),
              AppConst.kCommon8.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.locations.yourGeoIsUnavailable,
                    style: context.textStyle.textTypo.tx2SemiBold,
                  ),
                  Text(
                    t.locations.yourGeoIsUnavailable,
                    style: context.textStyle.descriptionTypo.des3,
                  ),
                ],
              ),
            ],
          ),
        ),
        orElse: SizedBox.new,
      ),
    ).paddingSymmetric(
      vertical: AppConst.kCommon12,
      horizontal: AppConst.kCommon16,
    );
  }
}
