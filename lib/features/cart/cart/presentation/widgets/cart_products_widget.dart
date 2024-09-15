import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_cards/product_cart_widget.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/enums/cart_clear_types.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';
import 'package:niagara_app/features/cart/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:niagara_app/features/cart/cart/presentation/widgets/delete_products_button_widget.dart';

/// Виджет, отображающий список доступных к заказу товаров в корзине.
class CartProductListWidget extends StatelessWidget {
  const CartProductListWidget({
    super.key,
    required this.cart,
  });

  /// Текущее состояние корзины.
  final Cart cart;

  /// Удаляет все товары, которые есть в наличии, из корзины.
  void _removeAllInStock(BuildContext context) => context.read<CartBloc>().add(
        const CartEvent.removeAllFromCart(type: CartClearTypes.inStock),
      );

  /// Добавляет товар в корзину.
  void _onAdd(BuildContext context, Product product) =>
      context.read<CartBloc>().add(CartEvent.addToCart(product: product));

  /// Удаляет товар из корзины.
  void _onRemove(BuildContext context, Product product) =>
      context.read<CartBloc>().add(CartEvent.removeFromCart(product: product));

  @override
  Widget build(BuildContext context) {
    if (cart.products.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: AppInsets.kHorizontal16 + AppInsets.kTop8,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DeleteProductsButtonWidget(
                onTap: () => _removeAllInStock(context),
              ),
            ],
          ),
          AppBoxes.kHeight12,
          ...cart.products.map(
            (product) => ProductBuyPreview(
              product: product,
              onAdd: () => _onAdd(context, product),
              onRemove: () => _onRemove(context, product),
            ),
          ),
        ],
      ),
    );
  }
}
