import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/product_favorite_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/product_tag_widget.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';

class ProductLabelAndFavorite extends StatelessWidget {
  const ProductLabelAndFavorite({
    required this.product,
    required this.isWaterBalance,
  });

  final Product product;

  final bool isWaterBalance;

  @override
  Widget build(BuildContext context) {
    final bool shouldDisplay = product.label.isNotEmpty && !isWaterBalance;

    return Positioned.fill(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (shouldDisplay)
            Padding(
              padding: AppInsets.kHorizontal6 + AppInsets.kVertical4,
              child: ProductTagWidget(
                label: product.label,
                labelColor: product.labelColor,
              ),
            ),
          const Spacer(),
          ProductFavoriteButton(product: product),
        ],
      ),
    );
  }
}
