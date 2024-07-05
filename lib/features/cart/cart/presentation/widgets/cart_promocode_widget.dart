import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/text_fields/app_text_field.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';

class CartPromocodeWidget extends StatelessWidget {
  const CartPromocodeWidget({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: AppInsets.kHorizontal16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.cart.hasPromocode,
            style: context.textStyle.textTypo.tx1SemiBold
                .withColor(context.colors.textColors.main),
          ),
          AppBoxes.kHeight8,
          AppTextField.promocode(
            label: t.cart.enterPromocode,
          ),
        ],
      ),
    );
  }
}
