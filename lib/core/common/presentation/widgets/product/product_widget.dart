import 'package:auto_route/auto_route.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/item_in_cart_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_coins_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_favorite_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_tag_widget.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/string_extension.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/cart/cart/presentation/bloc/cart_bloc/cart_bloc.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.product,
    this.goToPage,
  });

  final Product product;
  final VoidCallback? goToPage;

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

  void _addToCart(BuildContext context) =>
      context.read<CartBloc>().add(CartEvent.addToCart(product: product));

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          goToPage != null ? goToPage!() : _navigateToProductPage(context),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.mainColors.bgCard,
          borderRadius: AppBorders.kCircular8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: AppInsets.kAll6,
                child: Stack(
                  fit: StackFit.expand,
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
                    Positioned.fill(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (product.label.isNotEmpty)
                            Padding(
                              padding:
                                  AppInsets.kHorizontal6 + AppInsets.kVertical4,
                              child: ProductTagWidget(
                                label: product.label,
                                labelColor: product.labelColor,
                              ),
                            ),
                          const Spacer(),
                          ProductFavoriteButton(product: product),
                        ],
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
              ),
            ),
            Padding(
              padding: AppInsets.kAll6 + AppInsets.kBottom2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          style:
                              context.textStyle.descriptionTypo.des3.copyWith(
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
                  AppBoxes.kHeight4,
                  Text(
                    '${product.price} ${t.common.rub}'.spaceSeparateNumbers(),
                    style: context.textStyle.textTypo.tx1SemiBold.withColor(
                      context.colors.textColors.main,
                    ),
                  ),
                  AppBoxes.kHeight8,
                  BlocBuilder<CartBloc, CartState>(
                    builder: (_, state) {
                      final cartProducts = state.maybeWhen(
                        loaded: (cart, recommends) => cart.products,
                        orElse: () => <Product>[],
                      );
                      final productInCart =
                          cartProducts.any((e) => e.id == product.id);
                      final countInCart = cartProducts
                          .firstWhere(
                            (e) => e.id == product.id,
                            orElse: () => product,
                          )
                          .count;
                      return productInCart
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ItemInCartButton(
                                  product: product,
                                  cartAction: ItemInCartButtonIcon.minus,
                                ),
                                Padding(
                                  padding: AppInsets.kHorizontal16,
                                  child: Text(
                                    '$countInCart ${t.pieces}',
                                    style: context
                                        .textStyle.textTypo.tx2SemiBold
                                        .withColor(
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
                          : InkWell(
                              onTap: () => _addToCart(context),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: context.colors.buttonColors.accent,
                                  borderRadius: AppBorders.kCircular6,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: AppInsets.kVertical6,
                                        child: Assets.icons.shoppingCart.svg(
                                          width: AppSizes.kIconMedium,
                                          height: AppSizes.kIconMedium,
                                          colorFilter: ColorFilter.mode(
                                            context.colors.textColors.white,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
