import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/string_extension.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
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
            LinearProgressIndicator(
              value: currentAmount / maxAmount,
              color: activeColor,
              backgroundColor: inactiveColor,
              borderRadius: BorderRadius.circular(AppConst.kCommon8),
              minHeight: AppConst.kCommon4,
            ).paddingAll(AppConst.kCommon4),
            Positioned(
              left: 0,
              height: AppConst.kCommon8,
              width: AppConst.kCommon8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: activeColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              right: 0,
              height: AppConst.kCommon8,
              width: AppConst.kCommon8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: lastPointColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        AppConst.kCommon4.verticalBox,
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
