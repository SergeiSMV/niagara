import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';

class CartDataBonusesAddedWidget extends StatelessWidget {
  const CartDataBonusesAddedWidget({
    super.key,
    required this.cart,
  });

  final Cart cart;

  int get _bonusesAdded => cart.cartData.bonusesAccumulation.round();

  @override
  Widget build(BuildContext context) {
    if (_bonusesAdded == 0) return const SizedBox.shrink();
    return Padding(
      padding: AppInsets.kVertical4,
      child: Row(
        children: [
          Text(
            t.cart.bonusesAdded,
            style: context.textStyle.textTypo.tx2Medium
                .withColor(context.colors.textColors.main),
          ),
          AppBoxes.kWidth4,
          const Spacer(),
          Text(
            '+$_bonusesAdded',
            style: context.textStyle.textTypo.tx2Medium
                .withColor(context.colors.textColors.main),
          ),
          AppBoxes.kWidth4,
          Assets.icons.coinNiagara.svg(
            width: AppSizes.kIconMedium,
            height: AppSizes.kIconMedium,
          ),
        ],
      ),
    );
  }
}
