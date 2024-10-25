import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/amount_icon_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/unauthorized_widget.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/enums/cart_item_action.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/string_extension.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/cart/cart/presentation/bloc/cart_bloc/cart_bloc.dart';

/// Виджет-кнопка для добавления товара в корзину.
///
/// Если товара нет в корзине, отображает кнопку с иконкой корзины. Если товар
/// есть в корзине, отображает количество товара в корзине и кнопки `+` и `-`.
///
/// Отображается внизу страницы карточки товара в качестве
/// `bottomNavigationBar`.
class ProductAddToCartButton extends StatelessWidget {
  const ProductAddToCartButton({
    super.key,
    required this.product,
  });

  /// Товар, который добавляется в корзину.
  final Product product;

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<CartBloc>();
    final bool outOfStock = bloc.isOutOfStock(product);

    final CartState state = bloc.state;
    final List<Product> cartProducts = state.maybeWhen(
      loaded: (cart, recommends) => cart.products,
      loading: (cart, recommends) => cart?.products ?? [],
      orElse: () => [],
    );
    final bool productInCart = cartProducts.any((e) => e.id == product.id);
    final int? countInCart = cartProducts
        .firstWhere(
          (e) => e.id == product.id,
          orElse: () => product,
        )
        .count;

    void onMinus() {
      if (bloc.unauthrorized) {
        AuthorizationWidget.showModal(context);
        return;
      }

      bloc.add(CartEvent.removeFromCart(product: product));
    }

    void onPlus() {
      if (bloc.unauthrorized) {
        AuthorizationWidget.showModal(context);
        return;
      }

      bloc.add(CartEvent.addToCart(product: product));
    }

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
                          style: context.textStyle.textTypo.tx3Medium.copyWith(
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
                          AmountIconButton(
                            itemAction: ItemAction.minus,
                            onTap: onMinus,
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
                          AmountIconButton(
                            itemAction: ItemAction.plus,
                            onTap: onPlus,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : outOfStock
                ? AppTextButton.primary(text: t.common.outOfStock)
                : AppTextButton.primary(
                    icon: Assets.icons.shoppingCart,
                    text: t.catalog.toCard,
                    onTap: onPlus,
                  ),
      ),
    );
  }
}
