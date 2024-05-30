import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class ProductCoinsWidget extends StatelessWidget {
  const ProductCoinsWidget({
    super.key,
    required this.count,
    this.size = AppSizes.kIconSmall,
  });

  final int count;
  final double size;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.mainColors.bgCard,
        borderRadius: AppBorders.kCircular16,
      ),
      child: Row(
        children: [
          Assets.icons.coinNiagara.svg(
            width: size,
            height: size,
          ),
          AppBoxes.kWidth4,
          Text(
            t.catalog.upBonus(n: count),
            style: context.textStyle.captionTypo.c1
                .withColor(context.colors.textColors.main),
          ),
          AppBoxes.kWidth6,
        ],
      ),
    );
  }
}
