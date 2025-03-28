import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_borders.dart';
import '../../../../../utils/constants/app_insets.dart';
import '../../../../../utils/constants/app_sizes.dart';
import '../../../../domain/models/product.dart';
import '../../app_network_image_widget.dart';
import 'product_coins_widget.dart';
import 'product_tag_widget.dart';

class CartProductImageWidget extends StatelessWidget {
  const CartProductImageWidget({
    required this.product,
    super.key,
  });

  final Product product;

  @override
  Widget build(BuildContext context) => Flexible(
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: AppBorders.kCircular6,
              child: AppNetworkImageWidget(url: product.imageUrl),
            ),
            // TODO(kvbykov): Уточнить, должен ли рисоваться тег в корзине. В
            // дизайне нигде не нарисован.
            if (product.label.isNotEmpty && !product.isWater)
              Positioned(
                child: Padding(
                  padding: AppInsets.kHorizontal6 + AppInsets.kVertical4,
                  child: ProductTagWidget(
                    label: product.label,
                    labelColor: product.labelColor,
                  ),
                ),
              ),
            if (product.bonus > 0)
              Positioned(
                bottom: AppSizes.kZero,
                left: AppSizes.kZero,
                child: ProductCoinsWidget(
                  count: product.bonus,
                ),
              ),
          ],
        ),
      );
}
