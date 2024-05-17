import 'package:flutter/cupertino.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_tooltip.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class JoiningIsQuickAndEasyWidget extends StatelessWidget {
  const JoiningIsQuickAndEasyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.mainColors.bgCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppConst.kCommon32.verticalBox,
          Text(
            t.bonuses.aboutBonusesProgram.joiningIsQuickAndEasyTitle,
            style: context.textStyle.headingTypo.h3.withColor(
              context.colors.textColors.main,
            ),
          ),
          AppConst.kCommon16.verticalBox,
          Text.rich(
            t.bonuses.aboutBonusesProgram.joiningIsQuickAndEasyDescription(
              paragraph: (text) => TextSpan(
                text: text,
                style: const TextStyle(height: AppConst.kCommon08),
              ),
            ),
            style: context.textStyle.descriptionTypo.des2
                .withColor(context.colors.textColors.main),
          ),
          AppConst.kCommon32.verticalBox,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: AppConst.kCommon16.toInt(),
                child: Column(
                  children: [
                    AppConst.kCommon32.verticalBox,
                    _buildTooltip(
                      context,
                      text: t.bonuses.aboutBonusesProgram
                          .joiningIsQuickAndEasyDescriptionFirst,
                    ),
                    AppConst.kCommon16.verticalBox,
                    _buildTooltip(
                      context,
                      text: t.bonuses.aboutBonusesProgram
                          .joiningIsQuickAndEasyDescriptionSecond,
                    ),
                    AppConst.kCommon16.verticalBox,
                    _buildTooltip(
                      context,
                      text: t.bonuses.aboutBonusesProgram
                          .joiningIsQuickAndEasyDescriptionThird,
                    ),
                  ],
                ),
              ),
              AppConst.kCommon8.horizontalBox,
              Flexible(
                flex: (AppConst.kCommon16 - AppConst.kCommon1).toInt(),
                child: Assets.images.aboutBonuses.aboutPhone.image(),
              ),
            ],
          ),
        ],
      ).paddingSymmetric(horizontal: AppConst.kCommon16),
    );
  }

  AppTooltip _buildTooltip(
    BuildContext context, {
    required String text,
  }) {
    return AppTooltip(
      child: Text(
        text,
        style: context.textStyle.captionTypo.c1
            .withColor(context.colors.mainColors.white),
      ),
    );
  }
}
