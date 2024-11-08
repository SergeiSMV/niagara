import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses.dart';

class AccruedBonusesWidget extends StatelessWidget {
  const AccruedBonusesWidget(this.bonuses);

  final Bonuses bonuses;

  @override
  Widget build(BuildContext context) {
    final int count = bonuses.yearlyBonusCount;
    final String date = bonuses.yearlyBonusDateFormated;

    return Container(
      padding: AppInsets.kAll12,
      decoration: BoxDecoration(
        color: context.colors.mainColors.bgCard,
        borderRadius: AppBorders.kCircular12,
      ),
      child: Row(
        children: [
          Assets.images.coinX2.image(
            height: AppSizes.kGeneral64,
          ),
          AppBoxes.kWidth12,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.bonuses.bonusesToAccrue(n: count),
                style: context.textStyle.headingTypo.h3.withColor(
                  context.colors.textColors.main,
                ),
              ),
              AppBoxes.kHeight4,
              Text(
                '${t.bonuses.willBeAccrued(n: count)} $date',
                style: context.textStyle.textTypo.tx2Medium.withColor(
                  context.colors.textColors.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
