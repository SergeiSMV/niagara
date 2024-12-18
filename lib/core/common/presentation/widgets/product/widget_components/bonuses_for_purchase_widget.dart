import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/product_coins_widget.dart';

/// Отображает бонусы за покупку товара.
class BonusesForPurchaseWidget extends StatelessWidget {
  const BonusesForPurchaseWidget({
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      child: ProductCoinsWidget(
        count: product.bonus,
      ),
    );
  }
}
