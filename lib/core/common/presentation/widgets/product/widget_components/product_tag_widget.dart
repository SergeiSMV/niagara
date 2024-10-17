import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';

class ProductTagWidget extends StatelessWidget {
  const ProductTagWidget({
    super.key,
    required this.label,
    required this.labelColor,
    this.isBigSize = false,
  });

  final String label;
  final Color labelColor;
  final bool isBigSize;

  @override
  Widget build(BuildContext context) {
    if (label.isEmpty) return const SizedBox.shrink();

    final textStyle = isBigSize
        ? context.textStyle.textTypo.tx3SemiBold
        : context.textStyle.captionTypo.c1;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppBorders.kCircular4,
        color: labelColor,
      ),
      child: Padding(
        padding: AppInsets.kHorizontal8 + AppInsets.kVertical4,
        child: Text(
          label,
          style: textStyle.withColor(
            context.colors.textColors.white,
          ),
        ),
      ),
    );
  }
}
