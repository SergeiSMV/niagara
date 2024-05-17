import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/string_extension.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class BonusNextLevelAmountSlider extends StatelessWidget {
  const BonusNextLevelAmountSlider({
    required this.currentAmount,
    required this.maxAmount,
    super.key,
  });

  final int currentAmount;
  final int maxAmount;

  @override
  Widget build(BuildContext context) {
    final activeColor = context.colors.mainColors.accent;
    final inactiveColor = context.colors.mainColors.light;

    final percent = currentAmount / maxAmount;
    final lastPointColor = percent == 1 ? activeColor : inactiveColor;
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: AppInsets.kAll4,
              child: LinearProgressIndicator(
                value: currentAmount / maxAmount,
                color: activeColor,
                backgroundColor: inactiveColor,
                borderRadius: BorderRadius.circular(AppSizes.kGeneral8),
                minHeight: AppSizes.kGeneral4,
              ),
            ),
            Positioned(
              left: 0,
              height: AppSizes.kGeneral8,
              width: AppSizes.kGeneral8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: activeColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              right: 0,
              height: AppSizes.kGeneral8,
              width: AppSizes.kGeneral8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: lastPointColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        AppBoxes.kBoxV4,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.bonuses.yourSpent(amount: currentAmount).spaceSeparateNumbers(),
              style: context.textStyle.descriptionTypo.des3.withColor(
                context.colors.textColors.secondary,
              ),
            ),
            Text(
              '$maxAmount ${t.common.rub}'.spaceSeparateNumbers(),
              style: context.textStyle.descriptionTypo.des3.withColor(
                context.colors.textColors.secondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
