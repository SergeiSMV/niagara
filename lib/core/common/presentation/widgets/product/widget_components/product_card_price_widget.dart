import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/string_extension.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class ProductCardPriceWidget extends StatelessWidget {
  const ProductCardPriceWidget({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '${product.price} ${t.common.rub}'.spaceSeparateNumbers(),
          style: context.textStyle.textTypo.tx1SemiBold.withColor(
            context.colors.textColors.main,
          ),
        ),
        AppBoxes.kWidth4,
        if (product.hasDiscount)
          Text(
            '${product.priceOld} ${t.common.rub}'.spaceSeparateNumbers(),
            style: context.textStyle.descriptionTypo.des3.copyWith(
              color: context.colors.textColors.secondary,
              decoration: TextDecoration.lineThrough,
              decorationColor: context.colors.textColors.secondary,
            ),
          ),
      ],
    );
  }
}
