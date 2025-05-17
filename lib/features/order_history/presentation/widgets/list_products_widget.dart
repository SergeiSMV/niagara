import 'package:flutter/material.dart';

import '../../../../core/common/domain/models/product.dart';
import '../../../../core/utils/constants/app_boxes.dart';
import '../../../../core/utils/constants/app_insets.dart';
import 'product_item_widget.dart';

class ListProductsWidget extends StatelessWidget {
  const ListProductsWidget({
    required this.products,
    super.key,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) => SliverPadding(
        padding: AppInsets.kHorizontal16,
        sliver: SliverList.separated(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];

            return ProductItemWidget(
              product: product,
              productCount: product.count ?? 1,
            );
          },
          separatorBuilder: (_, __) => AppBoxes.kHeight8,
        ),
      );
}
