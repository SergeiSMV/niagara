import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';

class PayButton extends StatelessWidget {
  const PayButton({
    super.key,
    required this.cart,
    required this.redirectRoute,
    required this.text,
  });

  /// Состояни корзины, которое будет использоваться при оформлении заказа.
  final Cart cart;

  /// Маршрут, на который будет произведено перенаправление при нажатии на кнопку.
  final PageRouteInfo redirectRoute;

  /// Текст кнопки.
  final String text;

  bool get _inactive => cart.products.isEmpty;

  void _goToOrderPlacing(BuildContext context) =>
      context.pushRoute(redirectRoute);

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
          onTap: _inactive ? null : () => _goToOrderPlacing(context),
          child: Container(
            alignment: Alignment.center,
            padding: AppInsets.kHorizontal16,
            decoration: BoxDecoration(
              color: _inactive
                  ? context.colors.buttonColors.inactive.withOpacity(0.5)
                  : context.colors.buttonColors.primary,
              borderRadius: AppBorders.kCircular12,
            ),
            height: AppSizes.kButtonLarge,
            width: double.infinity,
            child: Row(
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
            ),
          ),
        ),
      ),
    );
  }
}
