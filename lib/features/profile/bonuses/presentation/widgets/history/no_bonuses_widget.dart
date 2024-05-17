import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class NoBonusesWidget extends StatelessWidget {
  const NoBonusesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.images.coins.image(),
          AppConst.kCommon24.verticalBox,
          Column(
            children: [
              Text(
                t.bonuses.youHaveNoBonuses,
                style: context.textStyle.headingTypo.h3
                    .withColor(context.colors.textColors.main),
                textAlign: TextAlign.center,
              ),
              AppConst.kCommon8.verticalBox,
              Text(
                t.bonuses.placeOrderToEarnPoints,
                style: context.textStyle.textTypo.tx1Medium
                    .withColor(context.colors.textColors.secondary),
                textAlign: TextAlign.center,
              ),
            ],
          ).paddingSymmetric(
            horizontal: AppConst.kCommon48,
            vertical: AppConst.kCommon8,
          ),
          AppConst.kCommon64.verticalBox,
        ],
      ),
    );
  }
}
