import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/prepaid_water_price_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/product_price_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/product_v_i_p_price_widget.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class ProductTitleWithPricesWidget extends StatelessWidget {
  const ProductTitleWithPricesWidget({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final bool isComplect = product.isWater;

    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.mainColors.white,
          borderRadius: AppBorders.kCircular16 + AppBorders.kCircular2,
        ),
        child: Padding(
          padding: AppInsets.kAll16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${t.catalog.article}: ${product.article}',
                style: context.textStyle.descriptionTypo.des4.withColor(
                  context.colors.textColors.secondary,
                ),
              ),
              AppBoxes.kHeight4,
              Text(
                product.name,
                style: context.textStyle.headingTypo.h3.withColor(
                  context.colors.textColors.main,
                ),
              ),
              if (product.description.isNotEmpty)
                Padding(
                  padding: AppInsets.kVertical12,
                  child: Text(
                    product.description,
                    style: context.textStyle.descriptionTypo.des2.withColor(
                      context.colors.textColors.secondary,
                    ),
                  ),
                ),
              AppBoxes.kHeight12,
              Row(
                children: [
                  if (isComplect)
                    PrepaidWaterPriceWidget(product: product)
                  else ...[
                    ProductPriceWidget(product: product),
                    AppBoxes.kWidth8,
                    if (product.hasVIPDiscount)
                      ProductVIPPriceWidget(product: product),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
