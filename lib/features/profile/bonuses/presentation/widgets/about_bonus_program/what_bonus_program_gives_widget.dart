import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/about_bonus_program/about_bonuses_description_build_widget.dart';

class WhatBonusProgramGivesWidget extends StatelessWidget {
  const WhatBonusProgramGivesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          t.bonuses.aboutBonusesProgram.whatBonusProgramGives,
          style: context.textStyle.headingTypo.h3.withColor(
            context.colors.textColors.main,
          ),
        ),
        AppConst.kCommon16.verticalBox,
        AboutBonusesDescriptionBuildWidget(
          image: Assets.images.aboutBonuses.aboutFirst,
          title: t.bonuses.aboutBonusesProgram.variousBonusesTitle,
          description: t.bonuses.aboutBonusesProgram.variousBonusesDescription,
        ),
        AppConst.kCommon24.verticalBox,
        AboutBonusesDescriptionBuildWidget(
          image: Assets.images.aboutBonuses.aboutSecond,
          title: t.bonuses.aboutBonusesProgram.bonusEqualsRubleTitle,
          description:
              t.bonuses.aboutBonusesProgram.bonusEqualsRubleDescription,
        ),
        AppConst.kCommon24.verticalBox,
        AboutBonusesDescriptionBuildWidget(
          image: Assets.images.aboutBonuses.aboutThird,
          title: t.bonuses.aboutBonusesProgram.annualBonusesFromNiagaraTitle,
          description:
              t.bonuses.aboutBonusesProgram.annualBonusesFromNiagaraDescription,
        ),
      ],
    ).paddingSymmetric(
      horizontal: AppConst.kCommon16,
      vertical: AppConst.kCommon24,
    );
  }
}
