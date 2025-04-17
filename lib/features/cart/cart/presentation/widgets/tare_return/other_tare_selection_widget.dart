import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/common/presentation/widgets/product/widget_components/amount_controls_widget.dart';
import '../../../../../../core/utils/constants/app_borders.dart';
import '../../../../../../core/utils/constants/app_boxes.dart';
import '../../../../../../core/utils/constants/app_insets.dart';
import '../../../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../../../core/utils/gen/assets.gen.dart';
import '../../../../../../core/utils/gen/strings.g.dart';
import '../../bloc/cart_bloc/cart_bloc.dart';

/// Виджет управления количеством тары (другого поставщика) к возврату
class OtherTareSelectionWidget extends StatelessWidget {
  const OtherTareSelectionWidget({
    required this.totalTares,
    required this.mainSelectedTares,
    required this.selectedTares,
    required this.amountRub,
    required this.taraNotation,
    super.key,
  });

  /// [totalTares] - общее количество тары, которое может быть возвращено
  /// [mainSelectedTares] - количество тары Niagara к возврату
  /// [selectedTares] - количество тары к возврату
  /// [amountRub] - стоимость тары в рублях
  /// [taraNotation] - faq по возврату тары другого поставщика

  final int totalTares;
  final int mainSelectedTares;
  final int selectedTares;
  final int amountRub;
  final String taraNotation;

  /// Увеличивает количество тары (другой поставщик) к возврату на 1
  void _onOtherTarePlus(BuildContext context) => context
      .read<CartBloc>()
      .add(const CartEvent.setOtherReturnTareCount(count: 1));

  /// Уменьшает количество тары (другой поставщик) к возврату на 1
  void _onOtherTareMinus(BuildContext context) => context
      .read<CartBloc>()
      .add(const CartEvent.setOtherReturnTareCount(count: -1));

  /// Выбирает все тары (другой поставщик) к возврату
  void _onAllToggled(BuildContext context) =>
      context.read<CartBloc>().add(const CartEvent.toggleAllOtherTare());

  /// показывает faq (всплывающее окно) по возврату тары другого поставщика
  Future<dynamic> _showOtherTareFaq(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: context.colors.mainColors.bgCard,
          shape: const RoundedRectangleBorder(
            borderRadius: AppBorders.kCircular12,
          ),
          contentPadding: AppInsets.kHorizontal16 + AppInsets.kTop24,
          actionsPadding: AppInsets.kHorizontal8,
          content: Text(
            taraNotation,
            style: context.textStyle.textTypo.tx2Medium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                t.cart.close,
                style: context.textStyle.textTypo.tx2SemiBold,
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    /// флаг, который определяет, выбраны ли все тары к возврату
    final bool allSelected = totalTares == selectedTares;

    /// чекбокс, который определяет, выбраны ли все тары к возврату
    final SvgGenImage icon = allSelected
        ? Assets.icons.checkboxChecked
        : Assets.icons.checkboxUnchecked;

    /// Находится ли корзина в состоянии загрузки.
    final bool loading = context.read<CartBloc>().state.maybeWhen(
          loading: (_, __, ___) => true,
          orElse: () => false,
        );

    return GestureDetector(
      onTap: !allSelected ? null : () => _onAllToggled(context),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.mainColors.bgCard,
          borderRadius: AppBorders.kCircular8,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: allSelected ? null : () => _onAllToggled(context),
                    child: Row(
                      children: [
                        icon.svg(),
                        AppBoxes.kWidth8,
                        Expanded(
                          child: Text(
                            t.cart.returnOtherTare,
                            style: context.textStyle.textTypo.tx2Medium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async => _showOtherTareFaq(context),
                  child: Assets.icons.question.svg(),
                ),
                AppBoxes.kWidth12,
                AmountControlsWidget(
                  count: selectedTares,
                  onAdd: !allSelected ? () => _onOtherTarePlus(context) : null,
                  onRemove: selectedTares > 0
                      ? () => _onOtherTareMinus(context)
                      : null,
                  alwaysShowActions: true,
                  shortAmount: true,
                  loading: loading,
                  countPadding: AppInsets.kHorizontal4,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
