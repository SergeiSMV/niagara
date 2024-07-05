import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/item_in_cart_button.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/string_extension.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/cart/cart/presentation/bloc/cart_bloc.dart';

class ProductToCardButton extends StatelessWidget {
  const ProductToCardButton({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (_, state) {
        final cartProducts = state.maybeWhen(
          loaded: (cart, recommends) => cart.products,
          orElse: () => <Product>[],
        );
        final productInCart = cartProducts.any((e) => e.id == product.id);
        final countInCart = cartProducts
            .firstWhere(
              (e) => e.id == product.id,
              orElse: () => product,
            )
            .count;

        return DecoratedBox(
          decoration: BoxDecoration(
            color: context.colors.mainColors.white,
            boxShadow: [
              BoxShadow(
                color: context.colors.textColors.main
                    .withOpacity(AppSizes.kShadowOpacity),
                blurRadius: AppSizes.kGeneral12,
                offset: AppConstants.kShadowTop,
              ),
            ],
          ),
          child: Padding(
            padding: AppInsets.kHorizontal16 +
                AppInsets.kVertical12 +
                AppInsets.kBottom12,
            child: productInCart
                ? DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.colors.mainColors.bgCard,
                      borderRadius: AppBorders.kCircular12,
                    ),
                    child: Padding(
                      padding: AppInsets.kAll16,
                      child: Row(
                        children: [
                          Text(
                            '${product.price} ${t.common.rub}'
                                .spaceSeparateNumbers(),
                            style: context.textStyle.headingTypo.h3
                                .withColor(context.colors.mainColors.primary),
                          ),
                          AppBoxes.kWidth4,
                          if (product.hasDiscount)
                            Text(
                              '${product.priceOld} ${t.common.rub}'
                                  .spaceSeparateNumbers(),
                              style:
                                  context.textStyle.textTypo.tx3Medium.copyWith(
                                color: context.colors.textColors.secondary,
                                decoration: TextDecoration.lineThrough,
                                decorationColor:
                                    context.colors.textColors.secondary,
                              ),
                            ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ItemInCartButton(
                                product: product,
                                cartAction: ItemInCartButtonIcon.minus,
                              ),
                              Padding(
                                padding: AppInsets.kHorizontal16,
                                child: Text(
                                  countInCart.toString(),
                                  style: context.textStyle.textTypo.tx2SemiBold
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
                        ],
                      ),
                    ),
                  )
                : AppTextButton.primary(
                    icon: Assets.icons.shoppingCart,
                    text: t.catalog.toCard,
                    onTap: () {},
                  ),
          ),
        );
      },
    );
  }
}
