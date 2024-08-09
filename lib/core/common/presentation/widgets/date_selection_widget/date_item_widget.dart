import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

class DateItemWidget extends StatelessWidget {
  const DateItemWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.showCalendarIcon = false,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final bool showCalendarIcon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: AppInsets.kVertical10,
          decoration: BoxDecoration(
            borderRadius: AppBorders.kCircular8,
            color: isSelected
                ? context.colors.mainColors.white
                : Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (showCalendarIcon)
                Assets.icons.calendarFill.svg(
                  height: AppSizes.kIconSmall,
                  width: AppSizes.kIconSmall,
                ),
              AppBoxes.kWidth8,
              Text(
                title,
                style: context.textStyle.textTypo.tx2SemiBold
                    .withColor(context.colors.textColors.main),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
