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
  const PrepaidWaterDescriptionBanner({super.key, this.backgroundColor});

  /// Цвет фона. По умолчанию - белый.
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: AppBorders.kCircular12,
            color: backgroundColor ?? context.colors.mainColors.white,
          ),
          child: Padding(
            padding: AppInsets.kAll16 + AppInsets.kBottom8,
            child: const _Content(),
          ),
        ),
        Positioned(
          top: AppSizes.kPrepaidWaterTopPositioning,
          right: AppSizes.kPrepaidWaterRightPositioning,
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
          number: t.prepaidWater.description.first.number,
          text: t.prepaidWater.description.first.text,
        ),
        AppBoxes.kHeight16,
        _DescriptionTile(
          number: t.prepaidWater.description.second.number,
          text: t.prepaidWater.description.second.text,
        ),
        AppBoxes.kHeight16,
        _DescriptionTile(
          number: t.prepaidWater.description.third.number,
          text: t.prepaidWater.description.third.text,
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
  final String number;

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
                number,
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
