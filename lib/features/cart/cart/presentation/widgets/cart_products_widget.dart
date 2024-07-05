import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_cart_widget.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';

class CartProductsWidget extends StatelessWidget {
  const CartProductsWidget({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kHorizontal16,
      child: Column(
        children: cart.products
            .map((product) => ProductCartWidget(product: product))
            .toList(),
      ),
    );
  }
}
