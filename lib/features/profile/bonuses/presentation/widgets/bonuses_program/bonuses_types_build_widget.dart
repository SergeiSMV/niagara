import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

class BonusesTypesBuildWidget extends StatelessWidget {
  const BonusesTypesBuildWidget({
    required this.image,
    required this.title,
    required this.descriptions,
    super.key,
  });

  final AssetGenImage image;
  final String title;
  final List<String> descriptions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kVertical8,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.mainColors.bgCard,
          borderRadius: BorderRadius.circular(AppSizes.kGeneral12),
        ),
        child: Column(
          children: [
            Padding(
              padding: AppInsets.kAll16,
              child: Row(
                children: [
                  image.image(height: AppSizes.kGeneral48),
                  AppBoxes.kWidth12,
                  Text(
                    title,
                    style: context.textStyle.textTypo.tx1SemiBold.withColor(
                      context.colors.textColors.main,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: context.colors.mainColors.light,
              height: AppSizes.kGeneral6,
              thickness: AppSizes.kGeneral1,
              indent: AppSizes.kGeneral12,
              endIndent: AppSizes.kGeneral12,
            ),
            ...List.generate(
              descriptions.length,
              (index) => Padding(
                padding: AppInsets.kHorizontal12 + AppInsets.kVertical6,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\u2022',
                      style: context.textStyle.headingTypo.h3.copyWith(
                        color: context.colors.textColors.secondary,
                        height: .6,
                      ),
                    ),
                    AppBoxes.kWidth8,
                    Flexible(
                      child: Text(
                        descriptions[index],
                        style: context.textStyle.textTypo.tx2Medium
                            .withColor(context.colors.textColors.secondary),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppBoxes.kHeight8,
          ],
        ),
      ),
    );
  }
}
