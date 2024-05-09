import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class AccruedBonusesWidget extends StatelessWidget {
  const AccruedBonusesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppConst.kCommon12.all,
      decoration: BoxDecoration(
        color: context.colors.mainColors.bgCard,
        borderRadius: BorderRadius.circular(AppConst.kCommon12),
      ),
      child: Row(
        children: [
          Assets.images.coinX2.image(
            height: AppConst.kCommon64,
          ),
          AppConst.kCommon12.horizontalBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '+524 бонуса',
                style: context.textStyle.headingTypo.h3.withColor(
                  context.colors.textColors.main,
                ),
              ),
              AppConst.kCommon4.verticalBox,
              Text(
                '${t.bonuses.willBeAccrued} 20 июня',
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
