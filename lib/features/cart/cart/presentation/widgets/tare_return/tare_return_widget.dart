import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/constants/app_borders.dart';
import '../../../../../../core/utils/constants/app_boxes.dart';
import '../../../../../../core/utils/constants/app_insets.dart';
import '../../../../../../core/utils/constants/app_sizes.dart';
import '../../../../../../core/utils/extensions/build_context_ext.dart';
import '../../../domain/models/cart.dart';
import '../../bloc/cart_bloc/cart_bloc.dart';
import 'main_tare_selection_widget.dart';
import 'other_tare_selection_widget.dart';
import 'tare_calculate_widget.dart';

/// Виджет тары к возврату
class TareReturnWidget extends StatelessWidget {
  const TareReturnWidget({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final CartData? data = state.maybeWhen(
            loaded: (cart, _) => cart.cartData,
            loading: (maybeCart, _, __) => maybeCart?.cartData,
            orElse: () => null,
          );

          if (data == null || data.totalTares == 0) {
            return const SizedBox.shrink();
          }

          return Padding(
            padding: AppInsets.kHorizontal16 + AppInsets.kTop16,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.colors.mainColors.bgCard,
                borderRadius: AppBorders.kCircular8,
              ),
              child: Padding(
                padding: AppInsets.kHorizontal12,
                child: Column(
                  spacing: AppSizes.kGeneral16,
                  children: [
                    AppBoxes.kHeight12,
                    // тара Niagara
                    MainTareSelectionWidget(
                      amountRub: data.tareSum,
                      otherSelectedTares: data.otherTareCount,
                      selectedTares: data.tareCount,
                      totalTares: data.totalTares,
                      taraExchangeInfo: data.taraExchangeInfo,
                    ),
                    Divider(color: context.colors.mainColors.light),
                    // тара другого поставщика
                    OtherTareSelectionWidget(
                      amountRub: data.otherTareSum,
                      mainSelectedTares: data.tareCount,
                      selectedTares: data.otherTareCount,
                      totalTares: data.totalTares,
                      taraNotation: data.taraNotation,
                    ),
                    Divider(color: context.colors.mainColors.light),
                    // общая сумма тары
                    TareCalculateWidget(
                      tareSum: data.tareSum,
                      taraProductInfo: data.taraProductInfo,
                    ),
                    AppBoxes.kHeight12,
                  ],
                ),
              ),
            ),
          );
        },
      );
}
