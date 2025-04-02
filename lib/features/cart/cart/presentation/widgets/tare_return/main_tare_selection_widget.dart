import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/common/presentation/widgets/product/widget_components/amount_controls_widget.dart';
import '../../../../../../core/utils/constants/app_boxes.dart';
import '../../../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../../../core/utils/extensions/text_style_ext.dart';
import '../../../../../../core/utils/gen/assets.gen.dart';
import '../../../../../../core/utils/gen/strings.g.dart';
import '../../bloc/cart_bloc/cart_bloc.dart';

/// Виджет управления количеством тары (Niagara) к возврату
class MainTareSelectionWidget extends StatelessWidget {
  const MainTareSelectionWidget({
    required this.totalTares,
    required this.selectedTares,
    required this.otherSelectedTares,
    required this.amountRub,
    super.key,
  });

  /// [totalTares] - общее количество тары, которое может быть возвращено
  /// [selectedTares] - количество тары Niagara к возврату
  /// [otherSelectedTares] - количество тары к возврату
  /// [amountRub] - стоимость тары в рублях

  final int totalTares;
  final int selectedTares;
  final int otherSelectedTares;
  final int amountRub;

  /// Увеличивает количество тары (Niagara) к возврату на 1
  void _onMainTarePlus(BuildContext context) => context
      .read<CartBloc>()
      .add(const CartEvent.setReturnTareCount(count: 1));

  /// Уменьшает количество тары (Niagara) к возврату на 1
  void _onMainTareMinus(BuildContext context) => context
      .read<CartBloc>()
      .add(const CartEvent.setReturnTareCount(count: -1));

  /// Выбирает все тары (Niagara) к возврату
  void _onAllToggled(BuildContext context) =>
      context.read<CartBloc>().add(const CartEvent.toggleAllTare());

  @override
  Widget build(BuildContext context) {
    final bool allSelected = totalTares == selectedTares;
    final SvgGenImage icon = allSelected
        ? Assets.icons.checkboxChecked
        : Assets.icons.checkboxUnchecked;

    return GestureDetector(
      onTap: !allSelected ? null : () => _onAllToggled(context),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: allSelected ? null : () => _onAllToggled(context),
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
                  onAdd: () => _onMainTarePlus(context),
                  onRemove: () => _onMainTareMinus(context),
                  alwaysShowActions: true,
                  shortAmount: true,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
