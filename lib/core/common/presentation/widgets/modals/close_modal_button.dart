import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

class CloseModalButton extends StatelessWidget {
  const CloseModalButton({
    required this.onTap,
    this.transparent = false,
    super.key,
  });

  final VoidCallback onTap;
  final bool transparent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: AppSizes.kIconLarge,
        height: AppSizes.kIconLarge,
        padding: AppInsets.kHorizontal2,
        decoration: BoxDecoration(
          color: transparent
              ? Colors.transparent
              : context.colors.buttonColors.secondary,
          borderRadius: AppBorders.kCircular6,
        ),
        child: Assets.icons.close.svg(
          colorFilter: ColorFilter.mode(
            context.colors.textColors.main,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
