import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Баннер с описанием механизма работы программы предоплатной воды.
class PrepaidWaterDescriptionBanner extends StatelessWidget {
  const PrepaidWaterDescriptionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: AppBorders.kCircular12,
            color: context.colors.mainColors.white,
          ),
          child: Padding(
            padding: AppInsets.kAll16 + AppInsets.kBottom8,
            child: const _Content(),
          ),
        ),
        Positioned(
          top: -AppSizes.kGeneral16,
          right: -AppSizes.kGeneral14,
          child: Assets.images.prepaidWater.image(
            width: AppSizes.kPrepaidWaterBannerWidth,
            height: AppSizes.kPrepaidWaterBannerHeight,
          ),
        ),
      ],
    );
  }
}

/// Пункты программы предоплатной воды.
class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          t.prepaidWater.description.title,
          style: context.textStyle.headingTypo.h2,
        ),
        AppBoxes.kHeight24,
        _DescriptionTile(
          number: 1,
          text: t.prepaidWater.description.first,
        ),
        AppBoxes.kHeight16,
        _DescriptionTile(
          number: 2,
          text: t.prepaidWater.description.second,
        ),
        AppBoxes.kHeight16,
        _DescriptionTile(
          number: 3,
          text: t.prepaidWater.description.third,
        ),
      ],
    );
  }
}

/// Описание пункта программы.
class _DescriptionTile extends StatelessWidget {
  const _DescriptionTile({
    required this.number,
    required this.text,
  });

  /// Номер пукнта программы.
  final int number;

  /// Текст пункта программы..
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.colors.infoColors.bgBlue,
          ),
          child: Padding(
            padding: AppInsets.kHorizontal10 + AppInsets.kVertical3,
            child: Center(
              child: Text(
                number.toString(),
                style: context.textStyle.buttonTypo.btn1bold
                    .withColor(context.colors.mainColors.primary),
              ),
            ),
          ),
        ),
        AppBoxes.kWidth12,
        Flexible(
          child: Text(
            text,
            style: context.textStyle.textTypo.tx2Medium,
          ),
        ),
      ],
    );
  }
}
