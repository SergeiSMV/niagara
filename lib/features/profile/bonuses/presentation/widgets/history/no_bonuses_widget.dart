import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class EmptyHistoryWidget extends StatelessWidget {
  const EmptyHistoryWidget({
    super.key,
    this.title,
    this.subtitle,
  });

  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.images.coins.image(),
          AppBoxes.kHeight24,
          Padding(
            padding: AppInsets.kHorizontal48 + AppInsets.kVertical8,
            child: Column(
              children: [
                Text(
                  title ?? t.bonuses.youHaveNoBonuses,
                  style: context.textStyle.headingTypo.h3
                      .withColor(context.colors.textColors.main),
                  textAlign: TextAlign.center,
                ),
                AppBoxes.kHeight8,
                Text(
                  subtitle ?? t.bonuses.placeOrderToEarnPoints,
                  style: context.textStyle.textTypo.tx1Medium
                      .withColor(context.colors.textColors.secondary),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          AppBoxes.kHeight64,
        ],
      ),
    );
  }
}
