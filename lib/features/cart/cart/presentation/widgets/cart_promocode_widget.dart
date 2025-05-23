import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common/presentation/widgets/text_fields/app_text_field.dart';
import '../../../../../core/utils/constants/app_boxes.dart';
import '../../../../../core/utils/constants/app_insets.dart';
import '../../../../../core/utils/enums/base_text_filed_state.dart';
import '../../../../../core/utils/enums/check_promocode_state.dart';
import '../../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../../core/utils/extensions/text_style_ext.dart';
import '../../../../../core/utils/gen/strings.g.dart';
import '../../domain/models/cart.dart';
import '../bloc/cart_bloc/cart_bloc.dart';
import '../bloc/check_promo_code_cubit/check_promo_code_cubit.dart';

/// Виджет для ввода промокода.
class CartPromocodeWidget extends StatelessWidget {
  const CartPromocodeWidget({
    required this.cart,
    super.key,
  });

  /// Корзина.
  final Cart cart;

  /// Обновление корзины.
  void _refreshCart(BuildContext context, String? promoCode) =>
      context.read<CartBloc>().add(
            CartEvent.setPromocode(promocode: promoCode ?? ''),
          );

  /// Обработчик изменения состояния промокода.
  void _promocodeStateListener(
    BuildContext context,
    CheckPromoCodeState state,
  ) {
    // Если промокод не валидный, то ничего не делаем
    if (state != CheckPromoCodeState.valid) return;

    // Получаем промокод из кубита и обновляем состояние корзины
    final cubit = context.read<CheckPromoCodeCubit>();
    _refreshCart(context, cubit.promocode);
  }

  /// Обработчик изменения состояния корзины.
  Future<void> _cartStateListener(BuildContext context, CartState _) async {
    final String promocode = context.read<CartBloc>().promocode;

    final cubit = context.read<CheckPromoCodeCubit>();
    if (cubit.promocode != promocode) {
      context.read<CheckPromoCodeCubit>()
        ..reset()
        ..promocode = promocode
        ..checkPromoCode();
    }
  }

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        margin: AppInsets.kHorizontal16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.cart.hasPromocode,
              style: context.textStyle.textTypo.tx1SemiBold
                  .withColor(context.colors.textColors.main),
            ),
            AppBoxes.kHeight8,
            BlocListener<CartBloc, CartState>(
              listener: _cartStateListener,
              child: BlocConsumer<CheckPromoCodeCubit, CheckPromoCodeState>(
                listener: _promocodeStateListener,
                builder: (context, state) {
                  final cubit = context.read<CheckPromoCodeCubit>();

                  final fieldState = switch (state) {
                    CheckPromoCodeState.valid => BaseTextFieldState.success,
                    CheckPromoCodeState.invalid =>
                      BaseTextFieldState.notSuccess,
                    CheckPromoCodeState.error => BaseTextFieldState.notSuccess,
                    CheckPromoCodeState.initial => BaseTextFieldState.idle,
                    CheckPromoCodeState.loading => BaseTextFieldState.idle,
                  };

                  return AppTextField.promocode(
                    initialText: cubit.promocode,
                    label: t.cart.enterPromocode,
                    onChanged: (value) {
                      cubit
                        ..reset()
                        ..promocode = value;
                    },
                    state: fieldState,
                    onTap: cubit.checkPromoCode,
                    loading: state == CheckPromoCodeState.loading,
                  );
                },
              ),
            ),
          ],
        ),
      );
}
