import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
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
            .map(
              (product) => Padding(
                padding: AppInsets.kVertical4,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.colors.mainColors.bgCard,
                    borderRadius: AppBorders.kCircular12,
                  ),
                  child: Row(
                    children: [
                      SizedBox.square(
                        dimension: 100,
                      )
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
