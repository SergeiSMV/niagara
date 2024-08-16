import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/snack_bars/app_snack_bar.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/enums/placing_order_error_type.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';
import 'package:niagara_app/features/cart/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:niagara_app/features/order_placing/presentation/bloc/create_order/create_order_cubit.dart';

/// Кнопка оформления заказа.
class CreateOrderButton extends StatelessWidget {
  const CreateOrderButton({
    super.key,
    required this.cart,
  });

  /// Состояни корзины, которое будет использоваться при оформлении заказа.
  final Cart cart;

  /// Обработчик состояния оформления заказа.
  ///
  /// В случае ошибки отображает сообщение об ошибке.
  ///
  /// В случае успешного оформления заказа перенаправляет на страницу результата.
  void _orderStateListener(BuildContext context, OrderCreationState state) =>
      state.mapOrNull(
        error: (err) => _orderErrorMapper(context, err.type),
        paymentRequired: (state) => context.replaceRoute(
          PaymentRoute(
            tokenizationData: state.data,
            successRoute: OrderResultRoute(isSuccessful: true),
            errorRoute: OrderResultRoute(isSuccessful: false),
          ),
        ),
        created: (_) {
          context.replaceRoute(OrderResultRoute(isSuccessful: true));
          context.read<CartBloc>().add(const CartEvent.getCart());
          return;
        },
      );

  /// Отображает сообщение об ошибке в зависимости от типа ошибки.
  void _orderErrorMapper(BuildContext context, OrderPlacingErrorType type) {
    String title;
    String? subtitle;

    switch (type) {
      case OrderPlacingErrorType.noInternet:
        title = t.errors.noInternet.title;

      case OrderPlacingErrorType.noDeliveryDate:
        title = t.errors.noDeliveryTime.title;

      case OrderPlacingErrorType.noPaymentMethod:
        title = t.errors.noPaymentMethod.title;

      case OrderPlacingErrorType.noRecipientData:
        title = t.errors.noRecipientData.title;

      case OrderPlacingErrorType.unknown:
        title = t.errors.unknownError.title;
    }

    AppSnackBar.showErrorShackBar(
      context,
      title: title,
      subtitle: subtitle,
    );
  }

  @override
  Widget build(BuildContext context) {
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
          onTap: context.read<OrderCreationCubit>().placeOrder,
          child: Container(
            alignment: Alignment.center,
            padding: AppInsets.kHorizontal16,
            decoration: BoxDecoration(
              color: context.colors.buttonColors.primary,
              borderRadius: AppBorders.kCircular12,
            ),
            height: AppSizes.kButtonLarge,
            width: double.infinity,
            child: BlocConsumer<OrderCreationCubit, OrderCreationState>(
              listener: _orderStateListener,
              builder: (context, state) => state.maybeWhen(
                loading: _Loading.new,
                orElse: () => _ButtonContent(cart: cart),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// TODO: Нужна белая анимация, нашу обычную на фоне кнопки не видно.
/// Виджет состояния загрузки.
class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kAll8,
      child: CircularProgressIndicator(
        color: context.colors.textColors.white,
      ),
    );
  }
}

/// Контент кнопки в обычном состоянии (отображает количество товаров, цену и
/// текст "Оплатить").
class _ButtonContent extends StatelessWidget {
  const _ButtonContent({
    required this.cart,
  });

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    final String text = t.orderPlacing.pay;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          t.product(n: cart.products.length),
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
