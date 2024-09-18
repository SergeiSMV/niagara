import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/product_coins_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/product_tag_widget.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';

class CartProductImageWidget extends StatelessWidget {
  const CartProductImageWidget({
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: AppBorders.kCircular6,
            child: ExtendedImage.network(
              product.imageUrl,
              fit: BoxFit.cover,
              loadStateChanged: (state) =>
                  state.extendedImageLoadState == LoadState.loading
                      ? const AppCenterLoader()
                      : null,
            ),
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
              bottom: 0,
              left: 0,
              child: ProductCoinsWidget(
                count: product.bonus,
              ),
            ),
        ],
      ),
    );
  }
}
