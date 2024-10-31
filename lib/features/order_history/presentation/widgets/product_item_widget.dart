import 'package:auto_route/auto_route.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    super.key,
    required this.product,
    required this.productCount,
  });

  final Product product;
  final int productCount;

  void _navigateToProductPage(BuildContext context) => context.navigateTo(
        ProductRoute(
          key: ValueKey(product.id),
          product: product,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _navigateToProductPage(context),
      child: Container(
        height: AppSizes.kOrderHistoryProductHeight,
        padding: AppInsets.kAll8,
        decoration: BoxDecoration(
          borderRadius: AppBorders.kCircular12,
          color: context.colors.mainColors.bgCard,
        ),
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: AppBorders.kCircular6,
                child: ExtendedImage.network(
                  product.imageUrl,
                  fit: BoxFit.contain,
                  loadStateChanged: (state) =>
                      state.extendedImageLoadState == LoadState.loading
                          ? const AppCenterLoader()
                          : null,
                ),
              ),
            ),
            AppBoxes.kWidth12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: context.textStyle.textTypo.tx2Medium,
                  ),
                  AppBoxes.kHeight6,
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${product.price} ${t.common.rub}',
                        style: context.textStyle.textTypo.tx1SemiBold,
                      ),
                      Text(
                        '$productCount ${t.pieces}',
                        style: context.textStyle.textTypo.tx2Medium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
