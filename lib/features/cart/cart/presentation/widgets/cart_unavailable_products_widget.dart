import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_cards/product_cart_widget.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/enums/cart_clear_types.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/cart/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:niagara_app/features/cart/cart/presentation/widgets/delete_products_button_widget.dart';

/// Отображает список товаров, которые недоступны для заказа.
class CartUnavailableProductsWidget extends StatelessWidget {
  const CartUnavailableProductsWidget({
    super.key,
    required this.unavailableProducts,
  });

  /// Список товаров, которые недоступны для заказа.
  final List<Product> unavailableProducts;

  bool get hasUnavailableProducts => unavailableProducts.isNotEmpty;

  /// Удаляет все недоступные для заказа товары из корзины.
  void _removeFromCartUnavailableProducts(BuildContext context) =>
      context.read<CartBloc>().add(
            const CartEvent.removeAllFromCart(type: CartClearTypes.outOfStock),
          );

  /// Добавляет товар в корзину.
  void _onAdd(BuildContext context, Product product) =>
      context.read<CartBloc>().add(CartEvent.addToCart(product: product));

  /// Удаляет товар из корзины.
  void _onRemove(BuildContext context, Product product) =>
      context.read<CartBloc>().add(CartEvent.removeFromCart(product: product));

  @override
  Widget build(BuildContext context) {
    if (!hasUnavailableProducts) return const SizedBox.shrink();
    return Padding(
      padding: AppInsets.kHorizontal16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.cart.unavailableForOrder,
                style: context.textStyle.textTypo.tx1SemiBold
                    .withColor(context.colors.textColors.main),
              ),
              DeleteProductsButtonWidget(
                onTap: () => _removeFromCartUnavailableProducts(context),
              ),
            ],
          ),
          AppBoxes.kHeight12,
          ...unavailableProducts.map(
            (product) => ProductBuyPreview(
              product: product,
              isAvailable: false,
              onAdd: () => _onAdd(context, product),
              onRemove: () => _onRemove(context, product),
            ),
          ),
        ],
      ),
    );
  }
}
