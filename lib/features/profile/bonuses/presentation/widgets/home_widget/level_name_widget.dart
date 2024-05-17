import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

class LevelNameWidget extends StatelessWidget {
  const LevelNameWidget({
    required this.level,
    super.key,
  });

  final String level;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: level,
        style: context.textStyle.textTypo.tx3SemiBold
            .withColor(context.colors.mainColors.white),
        children: [
          WidgetSpan(
            child: Assets.icons.arrowRight.svg(
              width: AppConst.kIconSmall,
              height: AppConst.kIconSmall,
              colorFilter: ColorFilter.mode(
                context.colors.mainColors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
      maxLines: AppConst.kCommon2.toInt(),
    );
  }
}
