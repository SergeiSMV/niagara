import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

class ProductSlidableButtonWidget extends StatelessWidget {
  const ProductSlidableButtonWidget({
    super.key,
    required this.buttonColor,
    required this.icon,
    required this.iconColor,
    this.onTap,
  });

  final Color buttonColor;
  final SvgGenImage icon;
  final Color iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppBorders.kCircular12,
            color: buttonColor,
          ),
          child: Center(
            child: icon.svg(
              height: AppSizes.kIconMedium,
              width: AppSizes.kIconMedium,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
