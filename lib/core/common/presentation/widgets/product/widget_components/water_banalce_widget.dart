import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class WaterBanalceWidget extends StatelessWidget {
  const WaterBanalceWidget({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          t.prepaidWater.balance,
          style: context.textStyle.descriptionTypo.des3.copyWith(
            color: context.colors.textColors.secondary,
          ),
        ),
        Text(
          '${product.count} ${t.pieces}',
          style: context.textStyle.textTypo.tx2SemiBold,
        ),
      ],
    );
  }
}
