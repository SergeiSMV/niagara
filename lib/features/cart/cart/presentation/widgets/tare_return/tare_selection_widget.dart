import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/amount_controls_widget.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Виджет управления количеством тары к возврату
class TareSelectionWidget extends StatelessWidget {
  const TareSelectionWidget({
    required this.totalTares,
    required this.selectedTares,
    required this.otherSelectedTares,
    required this.amountRub,
    required this.onPlus,
    required this.onMinus,
    required this.onAllToggled,
  });

  /// Общее количество тары к возврату
  final int totalTares;

  /// Количество тары к возврату (Niagara)
  final int selectedTares;

  /// Количество тары к возврату (другой поставщик)
  final int otherSelectedTares;

  /// Сумма тары к возврату в рублях
  final int amountRub;

  /// Увеличивает количество тары к возврату на 1
  final VoidCallback onPlus;

  /// Уменьшает количество тары к возврату на 1
  final VoidCallback onMinus;

  /// Выбирает все тары к возврату
  final VoidCallback onAllToggled;

  @override
  Widget build(BuildContext context) {
    final bool allSelected = totalTares == selectedTares;
    final SvgGenImage icon = allSelected
        ? Assets.icons.checkboxChecked
        : Assets.icons.checkboxUnchecked;

    return GestureDetector(
      onTap: !allSelected ? null : onAllToggled,
      child: Padding(
        padding: AppInsets.kAll16,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.colors.mainColors.bgCard,
            borderRadius: AppBorders.kCircular8,
          ),
          child: Padding(
            padding:
                AppInsets.kHorizontal12 + AppInsets.kTop12 + AppInsets.kBottom4,
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: allSelected ? null : onAllToggled,
                      child: Row(
                        children: [
                          icon.svg(),
                          AppBoxes.kWidth8,
                          Text(
                            t.cart.returnEmptyTare,
                            style: context.textStyle.textTypo.tx2Medium,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    if (allSelected)
                      Text(
                        '$totalTares ${t.pieces}',
                        style: context.textStyle.textTypo.tx1SemiBold.withColor(
                          context.colors.mainColors.primary,
                        ),
                      )
                    else
                      AmountControlsWidget(
                        count: selectedTares,
                        onAdd: onPlus,
                        onRemove: onMinus,
                        alwaysShowActions: true,
                        shortAmount: true,
                      ),
                  ],
                ),
                AppBoxes.kHeight12,
                if (!allSelected) ...[
                  Divider(color: context.colors.mainColors.light),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        t.cart.polycarbonateTare,
                        style: context.textStyle.textTypo.tx2Medium,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '$amountRub ${t.common.rub}',
                            style: context.textStyle.textTypo.tx1SemiBold,
                          ),
                          Text(
                            '${totalTares - selectedTares - otherSelectedTares} ${t.pieces}',
                            style: context.textStyle.descriptionTypo.des3
                                .withColor(
                              context.colors.textColors.secondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
