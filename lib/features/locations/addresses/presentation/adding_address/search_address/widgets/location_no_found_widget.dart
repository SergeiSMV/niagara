import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class LocationNotFoundWidget extends StatelessWidget {
  const LocationNotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textColors = context.colors.textColors;
    final textStyle = context.textStyle;

    return Center(
      heightFactor: AppSizes.kGeneral2,
      child: Padding(
        padding: AppInsets.kAll16,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Spacer(),
                Flexible(
                  flex: AppSizes.kGeneral2.toInt(),
                  child: Assets.images.search3D.image(),
                ),
                const Spacer(),
              ],
            ),
            AppBoxes.kHeight16,
            Text(
              t.search.thatAddressDoesntExist,
              style: textStyle.headingTypo.h3.withColor(textColors.main),
              textAlign: TextAlign.center,
            ),
            AppBoxes.kHeight8,
            Text(
              t.search.enterADifferentAddress,
              style:
                  textStyle.textTypo.tx3Medium.withColor(textColors.secondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
