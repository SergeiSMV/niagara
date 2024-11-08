import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/bonuses_for_purchase_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/product_label_and_favorite.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';

class ProductImageWithLabels extends StatelessWidget {
  const ProductImageWithLabels({
    required this.product,
    required this.isOnWaterBalancePage,
  });

  final Product product;
  final bool isOnWaterBalancePage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kAll6,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _ProductImage(product: product),
          ProductLabelAndFavorite(
            product: product,
            isWaterBalance: isOnWaterBalancePage,
          ),
          if (product.bonus > 0) BonusesForPurchaseWidget(product: product),
        ],
      ),
    );
  }
}

/// Отображает изображение товара.
class _ProductImage extends StatelessWidget {
  const _ProductImage({
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppBorders.kCircular6,
      child: ExtendedImage.network(
        product.imageUrl,
        fit: BoxFit.cover,
        loadStateChanged: (state) =>
            state.extendedImageLoadState == LoadState.loading
                ? const AppCenterLoader()
                : null,
      ),
    );
  }
}
