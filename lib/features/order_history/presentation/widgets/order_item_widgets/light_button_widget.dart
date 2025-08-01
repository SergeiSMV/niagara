import 'package:flutter/material.dart';
import '../../../../../core/utils/constants/app_borders.dart';
import '../../../../../core/utils/constants/app_boxes.dart';
import '../../../../../core/utils/constants/app_insets.dart';
import '../../../../../core/utils/constants/app_sizes.dart';
import '../../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../../core/utils/extensions/text_style_ext.dart';
import '../../../../../core/utils/gen/assets.gen.dart';

class LightButtonWidget extends StatelessWidget {
  const LightButtonWidget({
    required this.text,
    required this.onTap,
    super.key,
    this.icon,
  });

  /// Иконка
  final SvgGenImage? icon;

  /// Текст
  final String text;

  /// Callback
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Container(
          padding: AppInsets.kVertical8,
          decoration: BoxDecoration(
            borderRadius: AppBorders.kCircular8,
            color: context.colors.buttonColors.secondary,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                icon!.svg(
                  width: AppSizes.kIconSmall,
                  height: AppSizes.kIconSmall,
                ),
              if (icon != null) AppBoxes.kWidth4,
              Text(
                text,
                style: context.textStyle.textTypo.tx3SemiBold.withColor(
                  context.colors.buttonColors.primary,
                ),
              ),
            ],
          ),
        ),
      );
}
