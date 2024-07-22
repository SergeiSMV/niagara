import 'package:auto_route/auto_route.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/item_in_cart_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_coins_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_tag_widget.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/string_extension.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class ProductCartWidget extends StatelessWidget {
  const ProductCartWidget({
    super.key,
    required this.product,
    this.isAvailable = true,
  });

  final Product product;
  final bool isAvailable;

  void _navigateToProductPage(BuildContext context) => context.navigateTo(
        CatalogWrapper(
          children: [
            ProductRoute(
              key: ValueKey(product.id),
              product: product,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          Column(
            children: [
              Container(
                height: 20,
                width: 20,
                color: Colors.red,
              ),
              Container(
                height: 20,
                width: 20,
                color: Colors.green,
              ),
              // SlidableAction(
              //   onPressed: null,
              //   backgroundColor: Color(0xFF7BC043),
              //   foregroundColor: Colors.white,
              //   icon: Icons.archive,
              //   label: 'Archive',
              // ),
              // SlidableAction(
              //   onPressed: null,
              //   backgroundColor: Color(0xFF0392CF),
              //   foregroundColor: Colors.white,
              //   icon: Icons.save,
              //   label: 'Save',
              // ),
            ],
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _navigateToProductPage(context),
        child: Padding(
          padding: AppInsets.kVertical4,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.colors.mainColors.bgCard,
              borderRadius: AppBorders.kCircular12,
            ),
            child: Padding(
              padding: AppInsets.kAll8,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CartProductImageWidget(product: product),
                  AppBoxes.kWidth12,
                  _CartProductDescriptionWidget(
                    product: product,
                    isAvailable: isAvailable,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CartProductDescriptionWidget extends StatelessWidget {
  const _CartProductDescriptionWidget({
    required this.product,
    required this.isAvailable,
  });

  final Product product;
  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: AppSizes.kGeneral2.toInt(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                  style: context.textStyle.textTypo.tx3Medium.copyWith(
                    color: context.colors.textColors.secondary,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: context.colors.textColors.secondary,
                  ),
                ),
            ],
          ),
          AppBoxes.kHeight8,
          Text(
            product.name,
            style: context.textStyle.textTypo.tx2Medium.withColor(
              context.colors.textColors.main,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          AppBoxes.kHeight4,
          Row(
            children: [
              if (product.description.isNotEmpty)
                Text(
                  '${product.description} • ',
                  style: context.textStyle.descriptionTypo.des3.copyWith(
                    color: context.colors.textColors.secondary,
                    height: .1,
                  ),
                ),
              if (product.discountOfCount.isNotEmpty)
                Text(
                  product.discountOfCount,
                  style: context.textStyle.captionTypo.c1.withColor(
                    context.colors.infoColors.green,
                  ),
                ),
            ],
          ),
          AppBoxes.kHeight24,
          if (isAvailable)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ItemInCartButton(
                  product: product,
                  cartAction: ItemInCartButtonIcon.minus,
                ),
                Padding(
                  padding: AppInsets.kHorizontal16,
                  child: Text(
                    '${product.count} ${t.pieces}',
                    style: context.textStyle.textTypo.tx2SemiBold.withColor(
                      context.colors.mainColors.primary,
                    ),
                  ),
                ),
                ItemInCartButton(
                  product: product,
                  cartAction: ItemInCartButtonIcon.plus,
                ),
              ],
            )
          else
            Text(
              t.cart.notAvailable,
              style: context.textStyle.textTypo.tx2SemiBold.withColor(
                context.colors.textColors.secondary,
              ),
            ),
        ],
      ),
    );
  }
}

class _CartProductImageWidget extends StatelessWidget {
  const _CartProductImageWidget({
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
          if (product.label.isNotEmpty)
            Positioned.fill(
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
