import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../core/common/domain/models/product.dart';
import '../../../../core/common/presentation/router/app_router.gr.dart';
import '../../../../core/common/presentation/widgets/app_network_image_widget.dart';
import '../../../../core/utils/constants/app_borders.dart';
import '../../../../core/utils/constants/app_boxes.dart';
import '../../../../core/utils/constants/app_insets.dart';
import '../../../../core/utils/constants/app_sizes.dart';
import '../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../core/utils/gen/strings.g.dart';

/// Виджет для отображения продукта
class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    required this.product,
    required this.productCount,
    super.key,
  });

  /// Продукт.
  final Product product;

  /// Количество продукта.
  final int productCount;

  /// Метод для перехода в страницу продукта.
  Future<void> _navigateToProductPage(BuildContext context) async =>
      context.navigateTo(
        ProductRoute(
          key: ValueKey(product.id),
          product: product,
        ),
      );

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () async => _navigateToProductPage(context),
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
                  child: AppNetworkImageWidget(
                    url: product.imageUrl,
                    fit: BoxFit.contain,
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
