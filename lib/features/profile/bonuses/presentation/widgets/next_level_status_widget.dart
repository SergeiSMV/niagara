import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/enums/status_level_type.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/string_extension.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class NextLevelStatusWidget extends StatelessWidget {
  const NextLevelStatusWidget({
    required this.nextLevel,
    required this.toNextLevel,
    super.key,
  });

  final StatusLevel nextLevel;
  final int toNextLevel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: AppConst.kCommon2.toInt(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nextLevel.toLocale(),
                style: context.textStyle.textTypo.tx1SemiBold.withColor(
                  context.colors.textColors.main,
                ),
              ),
              AppConst.kCommon4.verticalBox,
              Text(
                t.bonuses
                    .toNextStatus(amount: toNextLevel)
                    .spaceSeparateNumbers(),
                style: context.textStyle.textTypo.tx2Medium.withColor(
                  context.colors.textColors.secondary,
                ),
              ),
            ],
          ),
        ),
        AppConst.kCommon16.horizontalBox,
        Flexible(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppConst.kCommon6),
            child: Stack(
              children: [
                nextLevel.cardImage.image(),
                Assets.images.logo
                    .svg(height: AppConst.kCommon8)
                    .paddingAll(AppConst.kCommon6),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
