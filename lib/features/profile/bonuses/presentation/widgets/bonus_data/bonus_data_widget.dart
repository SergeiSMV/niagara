import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

class BonusDataWidget extends StatelessWidget {
  const BonusDataWidget({
    required this.title,
    required this.value,
    required this.icon,
    super.key,
  });

  final String title;
  final String value;
  final SvgGenImage icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.mainColors.white,
        borderRadius: BorderRadius.circular(AppSizes.kGeneral12),
      ),
      child: Padding(
        padding: AppInsets.kAll8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.textStyle.textTypo.tx4Medium,
            ),
            AppBoxes.kHeight8,
            Row(
              children: [
                icon.svg(
                  width: AppSizes.kIconMedium,
                  height: AppSizes.kIconMedium,
                ),
                AppBoxes.kWidth6,
                Text(
                  value,
                  style: context.textStyle.textTypo.tx2SemiBold,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
