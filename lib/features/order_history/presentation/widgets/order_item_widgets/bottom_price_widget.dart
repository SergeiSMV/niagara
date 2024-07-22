import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/double_price_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class BottomPriceWidget extends StatelessWidget {
  const BottomPriceWidget({
    required this.price,
  });

  final double price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          t.recentOrders.costOfOrder,
          style: context.textStyle.textTypo.tx2SemiBold.withColor(
            context.colors.textColors.main,
          ),
        ),
        Text(
          '${price.priceString} ${t.common.rub}',
          style: context.textStyle.textTypo.tx2SemiBold.withColor(
            context.colors.textColors.main,
          ),
        ),
      ],
    );
  }
}
