import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/product_amount_icon_button.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/enums/cart_item_action.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Виджет, отображающий кнопки для изменения количества товара.
///
/// Если [count] равен 0, отображается кнопка с иконкой корзины. Иначе
/// отображаются количество товара и кнопки `+` и `-`.
class ProductCountControls extends StatelessWidget {
  const ProductCountControls({
    super.key,
    required this.product,
    required this.onRemove,
    required this.count,
    required this.onAdd,
  });

  /// Товар, для которого отображаются кнопки.
  final Product product;

  /// Коллбек, вызываемый при уменьшении количества товара.
  final VoidCallback onRemove;

  /// Коллбек, вызываемый при увеличении количества товара.
  final VoidCallback onAdd;

  /// Количество товара.
  final int count;

  @override
  Widget build(BuildContext context) {
    if (count == 0) {
      return InkWell(
        onTap: onAdd,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.colors.buttonColors.accent,
            borderRadius: AppBorders.kCircular6,
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: AppInsets.kVertical6,
                  child: Assets.icons.shoppingCart.svg(
                    width: AppSizes.kIconMedium,
                    height: AppSizes.kIconMedium,
                    colorFilter: ColorFilter.mode(
                      context.colors.textColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ProductAmountIconButton(
            product: product,
            cartAction: CartItemAction.minus,
            onTap: onRemove,
          ),
          Padding(
            padding: AppInsets.kHorizontal16,
            child: Text(
              '$count ${t.pieces}',
              style: context.textStyle.textTypo.tx2SemiBold.withColor(
                context.colors.mainColors.primary,
              ),
            ),
          ),
          ProductAmountIconButton(
            product: product,
            cartAction: CartItemAction.plus,
            onTap: onAdd,
          ),
        ],
      );
    }
  }
}
