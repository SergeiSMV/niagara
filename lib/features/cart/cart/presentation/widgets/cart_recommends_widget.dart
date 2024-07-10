import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_widget.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class CartRecommendsWidget extends StatelessWidget {
  const CartRecommendsWidget({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.mainColors.white,
          borderRadius: AppBorders.kCircular16 + AppBorders.kCircular2,
        ),
        child: Padding(
          padding: AppInsets.kVertical16,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: AppInsets.kHorizontal16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      t.catalog.recommendedViewing,
                      style: context.textStyle.textTypo.tx1SemiBold.withColor(
                        context.colors.textColors.main,
                      ),
                    ),
                  ],
                ),
              ),
              AppBoxes.kHeight12,
              AspectRatio(
                aspectRatio: 1.3,
                child: ListView.separated(
                  itemCount: products.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: AppInsets.kHorizontal16,
                  itemBuilder: (_, index) => AspectRatio(
                    aspectRatio: .5,
                    child: ProductWidget(product: products[index]),
                  ),
                  separatorBuilder: (_, __) => AppBoxes.kWidth8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
