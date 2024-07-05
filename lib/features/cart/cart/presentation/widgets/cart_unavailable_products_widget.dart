import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_cart_widget.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class CartUnavailableProductsWidget extends StatelessWidget {
  const CartUnavailableProductsWidget({
    super.key,
    required this.unavailableProducts,
  });

  final List<Product> unavailableProducts;

  bool get hasUnavailableProducts => unavailableProducts.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    if (!hasUnavailableProducts) return const SizedBox.shrink();
    return Padding(
      padding: AppInsets.kHorizontal16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.cart.unavailableForOrder,
            style: context.textStyle.textTypo.tx1SemiBold
                .withColor(context.colors.textColors.main),
          ),
          AppBoxes.kHeight12,
          ...unavailableProducts.map(
            (product) => ProductCartWidget(
              product: product,
              isAvailable: false,
            ),
          ),
        ],
      ),
    );
  }
}
