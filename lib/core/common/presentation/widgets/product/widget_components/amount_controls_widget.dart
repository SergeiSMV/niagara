import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_borders.dart';
import '../../../../../utils/constants/app_insets.dart';
import '../../../../../utils/constants/app_sizes.dart';
import '../../../../../utils/enums/cart_item_action.dart';
import '../../../../../utils/extensions/build_context_ext.dart';
import '../../../../../utils/extensions/text_style_ext.dart';
import '../../../../../utils/gen/assets.gen.dart';
import '../../../../../utils/gen/strings.g.dart';
import '../../loaders/app_center_loader.dart';
import 'amount_icon_button.dart';

/// Виджет, отображающий кнопки для изменения количества товара.
///
/// Если [count] равен 0, отображается кнопка с иконкой корзины. Иначе
/// отображаются количество товара и кнопки `+` и `-`.
class AmountControlsWidget extends StatelessWidget {
  const AmountControlsWidget({
    required this.onRemove,
    required this.count,
    required this.onAdd,
    super.key,
    this.shrink = false,
    this.shortAmount = false,
    this.alwaysShowActions = false,
    this.outOfStock = false,
    this.loading = false,
    this.countPadding,
  });

  /// Отступы для количества товара.
  ///
  /// Задаются для фиксирования отступов от кнопок `+` и `-`.
  final EdgeInsets? countPadding;

  /// Используется для отображения сообщения об отсутствии товара в наличии.
  ///
  /// В таком случае исчезнут кнопки `+` и `-`, а обработчики нажатий не
  /// будут вызываться.
  final bool outOfStock;

  /// Коллбек, вызываемый при уменьшении количества товара.
  final VoidCallback? onRemove;

  /// Коллбек, вызываемый при увеличении количества товара.
  final VoidCallback? onAdd;

  /// Количество товара.
  final int count;

  /// Способ отображения количества (`n` vs `n шт.`).
  final bool shortAmount;

  /// Должны ли всегда отображаться кнопки `+` и `-`, даже при нулевом [count].
  final bool alwaysShowActions;

  /// Отображает индикатор загрузки.
  final bool loading;

  /// Уменьшает отступы.
  final bool shrink;

  @override
  Widget build(BuildContext context) {
    if (count == 0 && !alwaysShowActions || outOfStock) {
      return InkWell(
        onTap: outOfStock ? null : onAdd,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: outOfStock || loading
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
                      : loading
                          ? const AppCenterLoader(
                              isWhite: true,
                              size: AppSizes.kIconMedium,
                              dense: true,
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
        mainAxisAlignment:
            shrink ? MainAxisAlignment.end : MainAxisAlignment.spaceBetween,
        children: [
          AmountIconButton(
            itemAction: ItemAction.minus,
            onTap: onRemove,
            loading: loading,
          ),
          Padding(
            padding: (countPadding ?? AppInsets.kHorizontal16) +
                AppInsets.kVertical4 +
                AppInsets.kHorizontal4,
            child: Container(
              width: countPadding != null ? 25 : null,
              alignment: Alignment.center,
              child: Text(
                '$count${shortAmount ? '' : ' ${t.pieces}'}',
                style: context.textStyle.textTypo.tx2SemiBold.withColor(
                  context.colors.mainColors.primary,
                ),
              ),
            ),
          ),
          AmountIconButton(
            itemAction: ItemAction.plus,
            onTap: onAdd,
            loading: loading,
          ),
        ],
      );
    }
  }
}
