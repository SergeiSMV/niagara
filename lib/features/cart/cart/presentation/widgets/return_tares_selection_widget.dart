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

class ReturnTaresSelectionWidget extends StatelessWidget {
  const ReturnTaresSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CartBloc>();
    void onPlus() => bloc.add(const CartEvent.setReturnTareCount(count: 1));
    void onMinus() => bloc.add(const CartEvent.setReturnTareCount(count: -1));
    void onAllToggled() => bloc.add(const CartEvent.toggleAllTare());

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

        return _TareSelectionWidget(
          amountRub: data.tareSum,
          selectedTares: data.tareCount,
          totalTares: data.totalTares,
          onPlus: onPlus,
          onMinus: onMinus,
          onAllToggled: onAllToggled,
        );
      },
    );
  }
}

class _TareSelectionWidget extends StatelessWidget {
  const _TareSelectionWidget({
    required this.totalTares,
    required this.selectedTares,
    required this.amountRub,
    required this.onPlus,
    required this.onMinus,
    required this.onAllToggled,
  });

  final int totalTares;
  final int selectedTares;
  final int amountRub;
  final VoidCallback onPlus;
  final VoidCallback onMinus;
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
                            '${totalTares - selectedTares} ${t.pieces}',
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
