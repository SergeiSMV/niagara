import 'package:flutter/cupertino.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_tooltip.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class JoiningIsQuickAndEasyWidget extends StatelessWidget {
  const JoiningIsQuickAndEasyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.mainColors.bgCard,
      child: Padding(
        padding: AppInsets.kHorizontal16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppBoxes.kHeight32,
            Text(
              t.bonuses.aboutBonusesProgram.joiningIsQuickAndEasyTitle,
              style: context.textStyle.headingTypo.h3.withColor(
                context.colors.textColors.main,
              ),
            ),
            AppBoxes.kHeight16,
            Text.rich(
              t.bonuses.aboutBonusesProgram.joiningIsQuickAndEasyDescription(
                paragraph: (text) => TextSpan(
                  text: text,
                  style: const TextStyle(height: .8),
                ),
              ),
              style: context.textStyle.descriptionTypo.des2
                  .withColor(context.colors.textColors.main),
            ),
            AppBoxes.kHeight32,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: AppSizes.kGeneral16.toInt(),
                  child: Column(
                    children: [
                      AppBoxes.kHeight32,
                      _buildTooltip(
                        context,
                        text: t.bonuses.aboutBonusesProgram
                            .joiningIsQuickAndEasyDescriptionFirst,
                      ),
                      AppBoxes.kHeight16,
                      _buildTooltip(
                        context,
                        text: t.bonuses.aboutBonusesProgram
                            .joiningIsQuickAndEasyDescriptionSecond,
                      ),
                      AppBoxes.kHeight16,
                      _buildTooltip(
                        context,
                        text: t.bonuses.aboutBonusesProgram
                            .joiningIsQuickAndEasyDescriptionThird,
                      ),
                    ],
                  ),
                ),
                AppBoxes.kWidth8,
                Flexible(
                  flex: (AppSizes.kGeneral16 - AppSizes.kGeneral1).toInt(),
                  child: Assets.images.aboutBonuses.aboutPhone.image(),
                ),
              ],
            ),
          ],
        ),
      ),
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
