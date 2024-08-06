import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

class PaymentMethodTypeItem extends StatelessWidget {
  const PaymentMethodTypeItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    required this.icon,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final SvgGenImage icon;

  @override
  Widget build(BuildContext context) {
    final unselectedColor = context.colors.fieldBordersColors.inactive;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: AppConstants.kSelectDateItemDuration,
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
              icon.svg(
                height: AppSizes.kIconSmall,
                width: AppSizes.kIconSmall,
                colorFilter: isSelected
                    ? null
                    : ColorFilter.mode(unselectedColor, BlendMode.srcIn),
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
