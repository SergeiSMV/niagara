import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class FAQBonusesWidget extends StatelessWidget {
  const FAQBonusesWidget({super.key});

  static final _questionsAndAnswers = [
    [
      t.bonuses.aboutBonusesProgram.faqQuestion1,
      t.bonuses.aboutBonusesProgram.faqAnswer1,
    ],
    [
      t.bonuses.aboutBonusesProgram.faqQuestion2,
      t.bonuses.aboutBonusesProgram.faqAnswer2,
    ],
    [
      t.bonuses.aboutBonusesProgram.faqQuestion3,
      t.bonuses.aboutBonusesProgram.faqAnswer3,
    ],
    [
      t.bonuses.aboutBonusesProgram.faqQuestion4,
      t.bonuses.aboutBonusesProgram.faqAnswer4,
    ],
    [
      t.bonuses.aboutBonusesProgram.faqQuestion5,
      t.bonuses.aboutBonusesProgram.faqAnswer5,
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppConst.kCommon24.verticalBox,
        Text(
          t.bonuses.aboutBonusesProgram.faq,
          style: context.textStyle.headingTypo.h3.withColor(
            context.colors.textColors.main,
          ),
        ),
        AppConst.kCommon8.verticalBox,
        ..._questionsAndAnswers.map(
          (e) => ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: Text(
              e.first,
              style: context.textStyle.textTypo.tx1Medium
                  .withColor(context.colors.textColors.main),
            ),
            shape: const Border(),
            collapsedShape: Border(
              bottom: BorderSide(
                color: context.colors.otherColors.separator30,
              ),
            ),
            iconColor: context.colors.textColors.main,
            collapsedIconColor: context.colors.textColors.main,
            children: [
              Text(
                e.last,
                style: context.textStyle.descriptionTypo.des2
                    .withColor(context.colors.textColors.main),
              ),
              AppConst.kCommon8.verticalBox,
            ],
          ).paddingSymmetric(horizontal: AppConst.kCommon16),
        ),
        AppConst.kCommon48.verticalBox,
      ],
    );
  }
}
