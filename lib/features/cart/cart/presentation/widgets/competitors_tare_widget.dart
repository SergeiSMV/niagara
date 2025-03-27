import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/amount_controls_widget.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';
import 'package:niagara_app/features/cart/cart/presentation/bloc/cart_bloc/cart_bloc.dart';

class CompetitorsTareWidget extends StatelessWidget {
  const CompetitorsTareWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CartBloc>();
    void onPlus() =>
        bloc.add(const CartEvent.setOtherReturnTareCount(count: 1));
    void onMinus() =>
        bloc.add(const CartEvent.setOtherReturnTareCount(count: -1));
    void onAllToggled() => bloc.add(const CartEvent.toggleAllOtherTare());

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final CartData? data = state.maybeWhen(
          loaded: (cart, _) => cart.cartData,
          loading: (maybeCart, _, __) => maybeCart?.cartData,
          orElse: () => null,
        );

        if (data == null || data.totalTares == 0) {
          return const SizedBox.shrink();
        }

        return _OtherTareSelectionWidget(
          amountRub: data.otherTareSum,
          mainSelectedTares: data.tareCount,
          selectedTares: data.otherTareCount,
          totalTares: data.totalTares,
          onPlus: onPlus,
          onMinus: onMinus,
          onAllToggled: onAllToggled,
          taraNotation: data.taraNotation,
        );
      },
    );
  }
}

class _OtherTareSelectionWidget extends StatelessWidget {
  const _OtherTareSelectionWidget({
    required this.totalTares,
    required this.mainSelectedTares,
    required this.selectedTares,
    required this.amountRub,
    required this.onPlus,
    required this.onMinus,
    required this.onAllToggled,
    required this.taraNotation,
  });

  /// [totalTares] - общее количество тары, которое может быть возвращено
  /// [mainSelectedTares] - количество тары Niagara к возврату
  /// [selectedTares] - количество тары к возврату
  /// [amountRub] - стоимость тары в рублях
  /// [onPlus] - тара к возврату +1
  /// [onMinus] - тара к возврату -1
  /// [onAllToggled] - выбрать все тары к возврату (равно [totalTares])
  /// [taraNotation] - faq по возврату тары другого поставщика

  final int totalTares;
  final int mainSelectedTares;
  final int selectedTares;
  final int amountRub;
  final VoidCallback onPlus;
  final VoidCallback onMinus;
  final VoidCallback onAllToggled;
  final String taraNotation;

  /// показывает faq (всплывающее окно) по возврату тары другого поставщика
  Future<dynamic> _showOtherTareFaq(BuildContext context) {
    return showDialog(
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
              'закрыть',
              style: context.textStyle.textTypo.tx2SemiBold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /// флаг, который определяет, выбраны ли все тары к возврату
    final bool allSelected = totalTares == selectedTares;

    /// чекбокс, который определяет, выбраны ли все тары к возврату
    final SvgGenImage icon = allSelected
        ? Assets.icons.checkboxChecked
        : Assets.icons.checkboxUnchecked;

    /// иконка вопроса (faq)
    final SvgGenImage faqIcon = Assets.icons.question;

    return GestureDetector(
      onTap: !allSelected ? null : onAllToggled,
      child: Padding(
        padding: AppInsets.kHorizontal16,
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
                    Expanded(
                      child: GestureDetector(
                        onTap: allSelected ? null : onAllToggled,
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
                    // faqIcon.svg(),
                    GestureDetector(
                      onTap: () => _showOtherTareFaq(context),
                      child: faqIcon.svg(),
                    ),
                    AppBoxes.kWidth12,
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
                            '${totalTares - selectedTares - mainSelectedTares} ${t.pieces}',
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
