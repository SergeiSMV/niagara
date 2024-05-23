import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class LocationUnavailableWidget extends StatelessWidget {
  const LocationUnavailableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.kGeneral12),
      margin: AppInsets.kVertical12 + AppInsets.kHorizontal16,
      decoration: BoxDecoration(
        color: context.colors.infoColors.bgRed,
        borderRadius: AppBorders.kCircular12,
      ),
      child: Row(
        children: [
          Assets.icons.closeFilling.svg(
            colorFilter: ColorFilter.mode(
              context.colors.fieldBordersColors.negative,
              BlendMode.srcIn,
            ),
          ),
          AppBoxes.kWidth8,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.locations.yourGeoIsUnavailable,
                style: context.textStyle.textTypo.tx2SemiBold,
              ),
              AppBoxes.kHeight4,
              Text(
                t.locations.yourGeoIsUnavailable,
                style: context.textStyle.descriptionTypo.des3,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
