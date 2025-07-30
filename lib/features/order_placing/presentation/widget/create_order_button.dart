import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/presentation/bloc/payment_method_selection_cubit/payment_method_selection_cubit.dart';
import '../../../../core/common/presentation/widgets/loaders/app_center_loader.dart';
import '../../../../core/utils/constants/app_borders.dart';
import '../../../../core/utils/constants/app_constants.dart';
import '../../../../core/utils/constants/app_insets.dart';
import '../../../../core/utils/constants/app_sizes.dart';
import '../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../core/utils/extensions/text_style_ext.dart';
import '../../../../core/utils/gen/strings.g.dart';
import '../../../cart/cart/domain/models/cart.dart';
import '../bloc/create_order/create_order_cubit.dart';

/// Кнопка оформления заказа.
class CreateOrderButton extends StatelessWidget {
  const CreateOrderButton({
    required this.cart,
    super.key,
  });

  /// Состояни корзины, которое будет использоваться при оформлении заказа.
  final Cart cart;

  @override
  Widget build(BuildContext context) {
    final bool loading = context.watch<OrderCreationCubit>().isLoading;
    final bool onlineMethod =
        context.watch<PaymentMethodSelectionCubit>().isOnline;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.mainColors.white,
        boxShadow: [
          BoxShadow(
            color: context.colors.textColors.main
                .withOpacity(AppSizes.kShadowOpacity),
            blurRadius: AppSizes.kGeneral12,
            offset: AppConstants.kShadowTop,
          ),
        ],
      ),
      child: Padding(
        padding: AppInsets.kHorizontal16 +
            AppInsets.kVertical12 +
            AppInsets.kBottom12,
        child: InkWell(
          onTap: loading
              ? null
              : () => context
                  .read<OrderCreationCubit>()
                  .placeOrder(allowZeroPrice: cart.cartData.totalPrice == 0),
          child: Container(
            alignment: Alignment.center,
            padding: AppInsets.kHorizontal16,
            decoration: BoxDecoration(
              color: loading
                  ? context.colors.buttonColors.inactive.withOpacity(0.5)
                  : context.colors.buttonColors.primary,
              borderRadius: AppBorders.kCircular12,
            ),
            height: AppSizes.kButtonLarge,
            width: double.infinity,
            child: BlocBuilder<OrderCreationCubit, OrderCreationState>(
              builder: (context, state) => state.maybeWhen(
                loading: _Loading.new,
                orElse: () =>
                    _ButtonContent(cart: cart, onlineMethod: onlineMethod),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Виджет состояния загрузки.
class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) => const Padding(
        padding: AppInsets.kAll8,
        child: AppCenterLoader(isWhite: true),
      );
}

/// Контент кнопки в обычном состоянии (отображает количество товаров, цену и
/// текст "Оплатить").
class _ButtonContent extends StatelessWidget {
  const _ButtonContent({
    required this.cart,
    required this.onlineMethod,
  });

  final Cart cart;
  final bool onlineMethod;

  @override
  Widget build(BuildContext context) {
    final String text =
        onlineMethod ? t.orderPlacing.pay : t.orderPlacing.order;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          t.product(n: cart.cartData.productsCount),
          style: context.textStyle.textTypo.tx2Medium
              .withColor(context.colors.textColors.white),
        ),
        Text(
          text,
          style: context.textStyle.buttonTypo.btn1bold
              .withColor(context.colors.textColors.white),
        ),
        Text(
          '${cart.cartData.totalPrice.round()} ${t.common.rub}',
          style: context.textStyle.textTypo.tx2Medium
              .withColor(context.colors.textColors.white),
        ),
      ],
    );
  }
}
