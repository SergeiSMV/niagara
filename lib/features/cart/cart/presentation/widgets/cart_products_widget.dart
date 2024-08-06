import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_cart_widget.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/enums/cart_clear_types.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';
import 'package:niagara_app/features/cart/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:niagara_app/features/cart/cart/presentation/widgets/delete_products_button_widget.dart';

class CartProductsWidget extends StatelessWidget {
  const CartProductsWidget({
    super.key,
    required this.cart,
  });

  final Cart cart;

  bool get hasProducts => cart.products.isNotEmpty;

  void _removeFromCartProducts(BuildContext context) =>
      context.read<CartBloc>().add(
            const CartEvent.removeAllFromCart(type: CartClearTypes.inStock),
          );

  @override
  Widget build(BuildContext context) {
    if (!hasProducts) return const SizedBox.shrink();
    return Padding(
      padding: AppInsets.kHorizontal16 + AppInsets.kTop8,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DeleteProductsButtonWidget(
                onTap: () => _removeFromCartProducts(context),
              ),
            ],
          ),
          AppBoxes.kHeight12,
          ...cart.products
              .map((product) => ProductCartWidget(product: product)),
        ],
      ),
    );
  }
}
