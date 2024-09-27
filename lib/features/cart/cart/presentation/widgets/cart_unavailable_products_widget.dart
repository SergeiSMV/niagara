import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_cards/product_in_cart.dart';
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

  /// Удаляет все недоступные для заказа товары из корзины.
  void _removeFromCartUnavailableProducts(BuildContext context) =>
      context.read<CartBloc>().add(
            const CartEvent.removeAllFromCart(type: CartClearTypes.outOfStock),
          );

  @override
  Widget build(BuildContext context) {
    if (unavailableProducts.isEmpty) return const SizedBox.shrink();

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
                unavailable: true,
              ),
            ],
          ),
          AppBoxes.kHeight12,
          ...unavailableProducts.map(
            (product) => ProductInCart(product: product),
          ),
        ],
      ),
    );
  }
}
