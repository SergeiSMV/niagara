import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_cart_widget.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';
import 'package:niagara_app/features/cart/cart/presentation/widgets/delete_products_button_widget.dart';

class CartProductsWidget extends StatelessWidget {
  const CartProductsWidget({
    super.key,
    required this.cart,
  });

  final Cart cart;

  bool get hasProducts => cart.products.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    if (!hasProducts) return const SizedBox.shrink();
    return Padding(
      padding: AppInsets.kHorizontal16,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DeleteProductsButtonWidget(
                onTap: () {
                  // TODO
                  // context.read<CartBloc>().add(
                  //       CartEvent.deleteProducts(products),
                  //     ),
                },
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
