import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Виджет с описанием правил реферальной программы.
class RulesWidget extends StatelessWidget {
  const RulesWidget({required this.rules, required this.description});

  final List<String> rules;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            t.referral.howItWorks,
            style: context.textStyle.headingTypo.h3,
          ),
        ),
        AppBoxes.kHeight16,
        _RuleWidget(
          image: Assets.images.referralLink3D,
          text: rules[0],
        ),
        AppBoxes.kHeight24,
        _RuleWidget(
          image: Assets.images.bags,
          text: rules[1],
        ),
        AppBoxes.kHeight24,
        _RuleWidget(
          image: Assets.images.cards,
          text: rules[2],
        ),
        AppBoxes.kHeight24,
        Padding(
          padding: AppInsets.kHorizontal21,
          child: Text(
            description,
            style: context.textStyle.descriptionTypo.des2.withColor(
              context.colors.textColors.secondary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _RuleWidget extends StatelessWidget {
  const _RuleWidget({required this.image, required this.text});

  final AssetGenImage image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kHorizontal21,
      child: Column(
        children: [
          image.image(
            width: AppSizes.kImageMediumWidth,
            height: AppSizes.kImageMediumHeight,
          ),
          AppBoxes.kHeight16,
          Text(
            text,
            style: context.textStyle.textTypo.tx2Medium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
