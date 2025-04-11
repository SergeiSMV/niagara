import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common/presentation/widgets/product/product_cards/product_in_cart.dart';
import '../../../../../core/utils/constants/app_boxes.dart';
import '../../../../../core/utils/constants/app_insets.dart';
import '../../../../../core/utils/enums/cart_clear_types.dart';
import '../../domain/models/cart.dart';
import '../bloc/cart_bloc/cart_bloc.dart';
import 'delete_products_button_widget.dart';

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
            (product) => ProductInCart(product: product),
          ),
        ],
      ),
    );
  }
}
