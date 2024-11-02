import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/amount_icon_button.dart';
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
class AmountControlsWidget extends StatelessWidget {
  const AmountControlsWidget({
    super.key,
    required this.onRemove,
    required this.count,
    required this.onAdd,
    this.shortAmount = false,
    this.alwaysShowActions = false,
    this.outOfStock = false,
  });

  /// Означает, что товар добавлен в корзину, но отсутствует в наличии.
  final bool outOfStock;

  /// Коллбек, вызываемый при уменьшении количества товара.
  final VoidCallback onRemove;

  /// Коллбек, вызываемый при увеличении количества товара.
  final VoidCallback onAdd;

  /// Количество товара.
  final int count;

  /// Способ отображения количества (`n` vs `n шт.`).
  final bool shortAmount;

  /// Должны ли всегда отображаться кнопки `+` и `-`, даже при нулевом [count].
  final bool alwaysShowActions;

  @override
  Widget build(BuildContext context) {
    if (count == 0 && !alwaysShowActions || outOfStock) {
      return InkWell(
        onTap: outOfStock ? null : onAdd,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: outOfStock
                ? context.colors.buttonColors.inactive.withOpacity(0.5)
                : context.colors.buttonColors.accent,
            borderRadius: AppBorders.kCircular6,
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: AppInsets.kVertical4,
                  child: outOfStock
                      ? Text(
                          t.common.outOfStock,
                          textAlign: TextAlign.center,
                          style:
                              context.textStyle.textTypo.tx3SemiBold.withColor(
                            context.colors.textColors.white,
                          ),
                        )
                      : Assets.icons.shoppingCart.svg(
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
          AmountIconButton(
            itemAction: ItemAction.minus,
            onTap: onRemove,
          ),
          Padding(
            padding: AppInsets.kHorizontal16 + AppInsets.kVertical4,
            child: Text(
              '$count${shortAmount ? '' : ' ${t.pieces}'}',
              style: context.textStyle.textTypo.tx2SemiBold.withColor(
                context.colors.mainColors.primary,
              ),
            ),
          ),
          AmountIconButton(
            itemAction: ItemAction.plus,
            onTap: onAdd,
          ),
        ],
      );
    }
  }
}
