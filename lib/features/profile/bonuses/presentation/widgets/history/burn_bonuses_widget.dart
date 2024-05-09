import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class BurnBonusesWidget extends StatelessWidget {
  const BurnBonusesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: AppConst.kCommon32,
      left: 0,
      right: 0,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.infoColors.bgRed,
          borderRadius: BorderRadius.circular(AppConst.kCommon12),
        ),
        child: ListTile(
          leading: Assets.icons.fireWhite.svg(
            width: AppConst.kIconLarge,
            height: AppConst.kIconLarge,
          ),
          title: Text(
            t.bonuses.aboutToBurnUpBonus(n: 100),
            style: context.textStyle.textTypo.tx2SemiBold
                .withColor(context.colors.textColors.main),
          ),
          subtitle: Text(
            t.bonuses.saveMoney,
            style: context.textStyle.descriptionTypo.des3
                .withColor(context.colors.textColors.main),
          ),
          trailing: Assets.icons.arrowRight.svg(
            width: AppConst.kIconMedium,
            height: AppConst.kIconMedium,
            colorFilter: ColorFilter.mode(
              context.colors.textColors.main,
              BlendMode.srcIn,
            ),
          ),
        ),
      ).paddingSymmetric(horizontal: AppConst.kCommon16),
    );
  }
}
