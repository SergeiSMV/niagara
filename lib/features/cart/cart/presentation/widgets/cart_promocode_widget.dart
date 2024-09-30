import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/text_fields/app_text_field.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/enums/base_text_filed_state.dart';
import 'package:niagara_app/core/utils/enums/check_promocode_state.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';
import 'package:niagara_app/features/cart/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:niagara_app/features/cart/cart/presentation/bloc/check_promo_code_cubit/check_promo_code_cubit.dart';

class CartPromocodeWidget extends StatelessWidget {
  const CartPromocodeWidget({
    super.key,
    required this.cart,
  });

  final Cart cart;

  void _getCard(BuildContext context, String? promoCode) =>
      context.read<CartBloc>().add(
            CartEvent.setPromocode(promocode: promoCode ?? ''),
          );

  @override
  Widget build(BuildContext context) {
    return Container(
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
          BlocConsumer<CheckPromoCodeCubit, CheckPromoCodeState>(
            listener: (context, state) {
              final cubit = context.read<CheckPromoCodeCubit>();

              if (state != CheckPromoCodeState.valid) return;

              _getCard(context, cubit.promocode);
            },
            builder: (context, state) {
              final cubit = context.read<CheckPromoCodeCubit>();

              final fieldState = switch (state) {
                CheckPromoCodeState.valid => BaseTextFieldState.success,
                CheckPromoCodeState.invalid => BaseTextFieldState.notSuccess,
                CheckPromoCodeState.error => BaseTextFieldState.notSuccess,
                CheckPromoCodeState.initial => BaseTextFieldState.idle,
                CheckPromoCodeState.loading => BaseTextFieldState.idle,
              };

              return AppTextField.promocode(
                initialText: cubit.promocode,
                label: t.cart.enterPromocode,
                onChanged: (value) {
                  cubit.reset();
                  cubit.promocode = value;
                },
                state: fieldState,
                onTap: () => cubit.checkPromoCode(),
                loading: state == CheckPromoCodeState.loading,
              );
            },
          ),
        ],
      ),
    );
  }
}
