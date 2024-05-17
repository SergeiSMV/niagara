import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonuses_program/unregistered_user_widget.dart';

class BonusesProgramHeaderWidget extends StatelessWidget {
  const BonusesProgramHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Assets.images.aboutBonuses.aboutBonusProgram.image(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.bonuses.aboutBonusesProgram.bonusProgram,
              style: context.textStyle.headingTypo.h2
                  .withColor(context.colors.mainColors.white),
            ),
            AppConst.kCommon16.verticalBox,
            Text.rich(
              t.bonuses.aboutBonusesProgram.bonusProgramDescription(
                paragraph: (text) => TextSpan(
                  text: text,
                  style: const TextStyle(height: AppConst.kCommon08),
                ),
              ),
              style: context.textStyle.textTypo.tx2Medium
                  .withColor(context.colors.mainColors.white),
            ),
            const UnregisteredUserWidget(),
          ],
        ).paddingSymmetric(
          horizontal: AppConst.kCommon16,
          vertical: AppConst.kCommon32,
        ),
      ],
    );
  }
}
