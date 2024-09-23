import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/enums/onboarding_step.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';

class OnboardingStepWidget extends StatelessWidget {
  const OnboardingStepWidget({
    required this.step,
    super.key,
  });

  final OnboardingStep step;

  @override
  Widget build(BuildContext context) {
    final double heightRatio = step == OnboardingStep.greeting
        ? AppSizes.kOnboardingImagetRatioLarge
        : AppSizes.kOnboardingImagetRatioSmall;

    return Padding(
      padding: AppInsets.kHorizontal24,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: context.screenHeight * heightRatio,
            width: AppSizes.kOnboardingImageBlockWidth,
            child: Align(
              child: step.image.image(),
            ),
          ),
          AppBoxes.kHeight12,
          Text(
            step.title,
            textAlign: TextAlign.center,
            style: context.textStyle.headingTypo.h2,
          ),
          AppBoxes.kHeight12,
          Text(
            step.description,
            textAlign: TextAlign.center,
            style: context.textStyle.textTypo.tx1Medium.withColor(
              context.colors.textColors.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
