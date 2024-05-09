import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

class BenefitBuilderWidget extends StatelessWidget {
  const BenefitBuilderWidget({
    required this.icon,
    required this.title,
    required this.description,
    super.key,
  });

  final SvgGenImage icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            icon.svg(
              width: AppConst.kIconMedium,
              height: AppConst.kIconMedium,
            ),
            AppConst.kCommon8.horizontalBox,
            Text(
              title,
              style: context.textStyle.textTypo.tx1SemiBold
                  .withColor(context.colors.textColors.main),
            ),
          ],
        ),
        AppConst.kCommon8.verticalBox,
        Text(
          description,
          style: context.textStyle.textTypo.tx2Medium
              .withColor(context.colors.textColors.secondary),
        ),
        AppConst.kCommon16.verticalBox,
      ],
    );
  }
}
