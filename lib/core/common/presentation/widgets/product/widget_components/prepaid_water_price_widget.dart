import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/string_extension.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class PrepaidWaterPriceWidget extends StatelessWidget {
  const PrepaidWaterPriceWidget({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.infoColors.green,
        borderRadius: AppBorders.kCircular8,
      ),
      child: Padding(
        padding: AppInsets.kHorizontal12 + AppInsets.kVertical8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${product.price} ${t.common.rub} '.spaceSeparateNumbers(),
                  style: context.textStyle.headingTypo.h3.withColor(
                    context.colors.textColors.white,
                  ),
                ),
                Text(
                  '${product.priceOld} ${t.common.rub}'.spaceSeparateNumbers(),
                  style: context.textStyle.textTypo.tx2Medium.copyWith(
                    color: context.colors.textColors.white,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: context.colors.textColors.white,
                  ),
                ),
              ],
            ),
            AppBoxes.kHeight2,
            Text(
              t.prepaidWater.complectBenefit,
              style: context.textStyle.textTypo.tx4Medium.withColor(
                context.colors.textColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
