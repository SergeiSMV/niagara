import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

class AboutBonusesDescriptionBuildWidget extends StatelessWidget {
  const AboutBonusesDescriptionBuildWidget({
    required this.image,
    required this.title,
    required this.description,
    super.key,
  });

  final AssetGenImage image;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        image.image(
          height: AppConst.kCommon64,
          width: AppConst.kCommon64,
        ),
        AppConst.kCommon16.verticalBox,
        Text(
          title,
          style: context.textStyle.textTypo.tx1SemiBold.withColor(
            context.colors.textColors.main,
          ),
          textAlign: TextAlign.center,
        ),
        AppConst.kCommon8.verticalBox,
        Text(
          description,
          style: context.textStyle.textTypo.tx2Medium.withColor(
            context.colors.textColors.secondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ).paddingSymmetric(horizontal: AppConst.kCommon24);
  }
}
