import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/text_fields/app_text_field.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/enums/base_text_filed_state.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';

class CartBonusesWidget extends StatelessWidget {
  const CartBonusesWidget({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppInsets.kAll12,
      margin: AppInsets.kAll16,
      decoration: BoxDecoration(
        color: context.colors.mainColors.bgCard,
        borderRadius: AppBorders.kCircular12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.cart.availableBonuses,
            style: context.textStyle.textTypo.tx1SemiBold
                .withColor(context.colors.textColors.main),
          ),
          AppBoxes.kHeight8,
          Row(
            children: [
              Assets.icons.coinNiagara.svg(
                width: AppSizes.kIconLarge,
                height: AppSizes.kIconLarge,
              ),
              AppBoxes.kWidth6,
              Text(
                cart.cartData.bonuses.round().toString(),
                style: context.textStyle.textTypo.tx1Medium
                    .withColor(context.colors.textColors.main),
              ),
            ],
          ),
          AppBoxes.kHeight16,
          AppTextField.bonuses(
            label: t.cart.enterQuantity,
            maxLength: cart.cartData.bonuses.round(),
            state: BaseTextFieldState.idle,
          ),
        ],
      ),
    );
  }
}
