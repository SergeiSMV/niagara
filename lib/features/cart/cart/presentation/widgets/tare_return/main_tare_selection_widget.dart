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

/// Виджет управления количеством тары (Niagara) к возврату
class MainTareSelectionWidget extends StatelessWidget {
  const MainTareSelectionWidget({
    required this.totalTares,
    required this.selectedTares,
    required this.otherSelectedTares,
    required this.amountRub,
    required this.taraExchangeInfo,
    super.key,
  });

  /// [totalTares] - общее количество тары, которое может быть возвращено
  /// [selectedTares] - количество тары Niagara к возврату
  /// [otherSelectedTares] - количество тары к возврату
  /// [amountRub] - стоимость тары в рублях
  /// [taraExchangeInfo] - информация о возврате тары

  final int totalTares;
  final int selectedTares;
  final int otherSelectedTares;
  final int amountRub;
  final String taraExchangeInfo;

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

  // показывает faq (всплывающее окно) по возврату тары Niagara
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
            taraExchangeInfo,
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
                          t.cart.returnEmptyTare,
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
                onAdd: allSelected ? null : () => _onMainTarePlus(context),
                onRemove:
                    selectedTares > 0 ? () => _onMainTareMinus(context) : null,
                alwaysShowActions: true,
                shortAmount: true,
                loading: loading,
                countPadding: AppInsets.kHorizontal4,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
