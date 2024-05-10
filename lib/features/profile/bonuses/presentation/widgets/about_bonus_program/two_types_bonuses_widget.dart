import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class TwoTypesBonusesWidget extends StatelessWidget {
  const TwoTypesBonusesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppConst.kCommon32.verticalBox,
        Text(
          t.bonuses.aboutBonusesProgram.twoTypesBonuses,
          style: context.textStyle.headingTypo.h3.withColor(
            context.colors.textColors.main,
          ),
        ),
        AppConst.kCommon8.verticalBox,
        _BonusesTypesBuildWidget(
          image: Assets.images.aboutBonuses.aboutFour,
          title: t.bonuses.aboutBonusesProgram.primaryBonusesTitle,
          descriptions: [
            t.bonuses.aboutBonusesProgram.primaryBonusesFirst,
            t.bonuses.aboutBonusesProgram.primaryBonusesSecond,
            t.bonuses.aboutBonusesProgram.primaryBonusesThird,
          ],
        ),
        _BonusesTypesBuildWidget(
          image: Assets.images.aboutBonuses.aboutFive,
          title: t.bonuses.aboutBonusesProgram.temporaryBonusesTitle,
          descriptions: [
            t.bonuses.aboutBonusesProgram.temporaryBonusesFirst,
            t.bonuses.aboutBonusesProgram.temporaryBonusesSecond,
            t.bonuses.aboutBonusesProgram.temporaryBonusesThird,
          ],
        ),
        AppConst.kCommon8.verticalBox,
      ],
    ).paddingSymmetric(horizontal: AppConst.kCommon16);
  }
}

class _BonusesTypesBuildWidget extends StatelessWidget {
  const _BonusesTypesBuildWidget({
    required this.image,
    required this.title,
    required this.descriptions,
  });

  final AssetGenImage image;
  final String title;
  final List<String> descriptions;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.mainColors.bgCard,
        borderRadius: BorderRadius.circular(AppConst.kCommon12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              image.image(height: AppConst.kCommon48),
              AppConst.kCommon12.horizontalBox,
              Text(
                title,
                style: context.textStyle.textTypo.tx1SemiBold.withColor(
                  context.colors.textColors.main,
                ),
              ),
            ],
          ).padding(
            left: AppConst.kCommon16,
            right: AppConst.kCommon16,
            top: AppConst.kCommon16,
            bottom: AppConst.kCommon6,
          ),
          Divider(
            color: context.colors.mainColors.light,
            height: AppConst.kCommon6,
            thickness: AppConst.kCommon1,
            indent: AppConst.kCommon12,
            endIndent: AppConst.kCommon12,
          ),
          ...List.generate(
            descriptions.length,
            (index) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\u2022',
                  style: context.textStyle.headingTypo.h3.copyWith(
                    color: context.colors.textColors.secondary,
                    height: .6,
                  ),
                ),
                AppConst.kCommon8.horizontalBox,
                Flexible(
                  child: Text(
                    descriptions[index],
                    style: context.textStyle.textTypo.tx2Medium
                        .withColor(context.colors.textColors.secondary),
                  ),
                ),
              ],
            ).paddingSymmetric(
              horizontal: AppConst.kCommon12,
              vertical: AppConst.kCommon6,
            ),
          ),
          AppConst.kCommon8.verticalBox,
        ],
      ),
    ).paddingSymmetric(vertical: AppConst.kCommon8);
  }
}
