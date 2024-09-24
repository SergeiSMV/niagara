import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
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
    return Padding(
      padding: AppInsets.kHorizontal24,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          image.image(
            height: AppSizes.kGeneral64,
            width: AppSizes.kGeneral64,
          ),
          AppBoxes.kHeight16,
          Text(
            title,
            style: context.textStyle.textTypo.tx1SemiBold.withColor(
              context.colors.textColors.main,
            ),
            textAlign: TextAlign.center,
          ),
          AppBoxes.kHeight8,
          Text(
            description,
            style: context.textStyle.textTypo.tx2Medium.withColor(
              context.colors.textColors.secondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
