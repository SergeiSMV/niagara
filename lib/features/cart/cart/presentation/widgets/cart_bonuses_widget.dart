import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/text_fields/app_text_field.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/enums/base_text_filed_state.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';
import 'package:niagara_app/features/cart/cart/presentation/bloc/cart_bloc/cart_bloc.dart';

class CartBonusesWidget extends StatefulWidget {
  const CartBonusesWidget({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  State<CartBonusesWidget> createState() => _CartBonusesWidgetState();
}

class _CartBonusesWidgetState extends State<CartBonusesWidget> {
  int current = 0;

  @override
  void initState() {
    super.initState();
    current = widget.cart.cartData.bonusesPayment.round();
  }

  @override
  Widget build(BuildContext context) {
    /// Сколько для этой корзины всего можно списать бонусов.
    final int maxValue = widget.cart.cartData.bonuses.round();

    /// Сколько в текущем сотоянии корзины уже применено бонусов.
    final int applied = widget.cart.cartData.bonusesPayment.round();

    /// Применить бонусы можно:
    /// - если пытаемся списать меньше или столько же, сколько доступно;
    /// - если новое число отличается от уже примененного;
    final bool canApply = current != applied && current <= maxValue;

    void applyBonuses() => context.read<CartBloc>().add(
          CartEvent.setBonusesToPay(bonuses: current),
        );

    /// Меняем [current]
    void onChanged(String? value) {
      final int newValue = int.tryParse(value ?? '') ?? 0;
      setState(() => current = newValue);
    }

    /// Т.к. бонусы прикручены к состоянию корзины, считаем, что они загружаются
    /// тогда, когда загружается корзина.
    final bool loading = context.read<CartBloc>().state.maybeWhen(
          loading: (_, __) => true,
          orElse: () => false,
        );

    return Container(
      width: double.infinity,
      padding: AppInsets.kAll12,
      margin: AppInsets.kAll16,
      decoration: BoxDecoration(
        color: context.colors.mainColors.bgCard,
        borderRadius: AppBorders.kCircular12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.cart.availableBonuses,
            style: context.textStyle.textTypo.tx1SemiBold
                .withColor(context.colors.textColors.main),
          ),
          AppBoxes.kHeight8,
          Row(
            children: [
              Assets.icons.coinNiagara.svg(
                width: AppSizes.kIconLarge,
                height: AppSizes.kIconLarge,
              ),
              AppBoxes.kWidth6,
              Text(
                widget.cart.cartData.bonuses.round().toString(),
                style: context.textStyle.textTypo.tx1Medium
                    .withColor(context.colors.textColors.main),
              ),
            ],
          ),
          AppBoxes.kHeight16,
          AppTextField.bonuses(
            label: t.cart.enterQuantity,
            onChanged: onChanged,
            initial: current != 0 ? current.toString() : null,
            maxValue: widget.cart.cartData.bonuses.round(),
            onApplied: canApply ? applyBonuses : null,
            loading: loading && canApply,
            state: current == applied && current != 0
                ? BaseTextFieldState.success
                : BaseTextFieldState.idle,
          ),
        ],
      ),
    );
  }
}
