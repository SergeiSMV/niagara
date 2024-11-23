import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/string_extension.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';
import 'package:niagara_app/features/cart/cart/presentation/bloc/cart_bloc/cart_bloc.dart';

class ProductPriceWidget extends StatelessWidget {
  const ProductPriceWidget({
    super.key,
    required this.product,
  });

  final Product product;

  int? _getPrice(Product product, CartState state) {
    final Cart? cart = state.maybeWhen(
      loaded: (cart, _) => cart,
      loading: (cart, _, __) => cart,
      orElse: () => null,
    );

    return cart?.priceInStock(product);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<CartBloc>();
    final int? priceInStock = _getPrice(product, bloc.state);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.mainColors.bgCard,
        borderRadius: AppBorders.kCircular8,
      ),
      child: Padding(
        padding: AppInsets.kHorizontal12 + AppInsets.kVertical8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${priceInStock ?? product.price} ${t.common.rub} '
                      .spaceSeparateNumbers(),
                  style: context.textStyle.headingTypo.h3.withColor(
                    context.colors.textColors.main,
                  ),
                ),
                if (product.hasDiscount)
                  Text(
                    '${product.priceOld} ${t.common.rub}'
                        .spaceSeparateNumbers(),
                    style: context.textStyle.textTypo.tx2Medium.copyWith(
                      color: context.colors.textColors.secondary,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: context.colors.textColors.secondary,
                    ),
                  )
                else if (priceInStock != null && priceInStock != product.price)
                  Text(
                    '${product.price} ${t.common.rub}'.spaceSeparateNumbers(),
                    style: context.textStyle.textTypo.tx2Medium.copyWith(
                      color: context.colors.textColors.secondary,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: context.colors.textColors.secondary,
                    ),
                  ),
              ],
            ),
            if (product.hasVIPDiscount) ...[
              AppBoxes.kHeight2,
              Text(
                t.catalog.withoutVIP,
                style: context.textStyle.textTypo.tx4Medium.withColor(
                  context.colors.textColors.secondary,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
