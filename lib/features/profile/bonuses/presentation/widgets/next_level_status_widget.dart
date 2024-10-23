import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/enums/status_level_type.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/string_extension.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class NextLevelStatusWidget extends StatelessWidget {
  const NextLevelStatusWidget({
    required this.nextLevel,
    required this.toNextLevel,
    required this.toKeepAmount,
    required this.isMax,
    super.key,
  });

  final StatusLevel nextLevel;
  final int toKeepAmount;
  final int toNextLevel;
  final bool isMax;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: AppSizes.kGeneral2.toInt(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${nextLevel.toLocale} ${t.bonuses.status.toLowerCase()}',
                style: context.textStyle.textTypo.tx1SemiBold.withColor(
                  context.colors.textColors.main,
                ),
              ),
              AppBoxes.kHeight4,
              Text(
                isMax
                    ? t.bonuses
                        .toKeepLevel(amount: toKeepAmount)
                        .spaceSeparateNumbers()
                    : t.bonuses
                        .toNextStatus(amount: toNextLevel)
                        .spaceSeparateNumbers(),
                style: context.textStyle.textTypo.tx2Medium.withColor(
                  context.colors.textColors.secondary,
                ),
              ),
            ],
          ),
        ),
        AppBoxes.kWidth16,
        Flexible(
          child: ClipRRect(
            borderRadius: AppBorders.kCircular6,
            child: Stack(
              children: [
                nextLevel.cardImage.image(),
                Padding(
                  padding: AppInsets.kAll6,
                  child: Assets.images.logo.svg(height: AppSizes.kGeneral8),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
