import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

class BonusesFooterButton extends StatelessWidget {
  const BonusesFooterButton({
    required this.icon,
    required this.title,
    required this.onTap,
    super.key,
  });

  final SvgGenImage icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: AppInsets.kSymmetricV16,
        child: Row(
          children: [
            icon.svg(
              width: AppSizes.kIconMedium,
              height: AppSizes.kIconMedium,
            ),
            AppBoxes.kBoxH12,
            Text(
              title,
              style: context.textStyle.textTypo.tx2Medium.withColor(
                context.colors.textColors.main,
              ),
            ),
            const Spacer(),
            Assets.icons.arrowRight.svg(
              width: AppSizes.kIconMedium,
              height: AppSizes.kIconMedium,
            ),
          ],
        ),
      ),
    );
  }
}
