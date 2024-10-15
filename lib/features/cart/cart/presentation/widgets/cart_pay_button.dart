import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/snack_bars/app_snack_bar.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
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

  bool get _noAddress => cart.locationId.isEmpty;
  bool get _inactive => cart.products.isEmpty || _noAddress;

  void _proceedToPayment(BuildContext context) {
    if (cart.minLimit.minAmountLeft > 0) {
      _showMinimumOrderAmountError(context);
    } else {
      // TODO: Это отображает модальное окно с предложением перенести
      // отсутствующие товары в избранное. Пока решили не реализовывать.
      // if (cart.unavailableProducts.isNotEmpty) {
      //   _showUnavailableProductsToFavorites(context);
      //   return;
      // }

      context.pushRoute(redirectRoute);
    }
  }

  // TODO: Расскоментировать в https://digitalburo.youtrack.cloud/issue/NIAGARA-375
  // /// Отображает модальное окно с предложением перенести отсутствующие товары в
  // /// избранное.
  // void _showUnavailableProductsToFavorites(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     backgroundColor: context.colors.mainColors.white,
  //     builder: (context) {
  //       return const UnavailableProductsToFavoritesWidget();
  //     },
  //   );
  // }

  /// Отображает сообщение об ошибке, если минимальная сумма заказа не
  /// достигнута.
  void _showMinimumOrderAmountError(BuildContext context) {
    AppSnackBar.showError(
      context,
      title: t.cart.minimumOrderAmount(n: cart.minLimit.minAmount.round()),
      subtitle: t.cart.needToSelectMore(n: cart.minLimit.minAmountLeft.round()),
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
          onTap: (_inactive || _noAddress)
              ? null
              : () => _proceedToPayment(context),
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
              mainAxisAlignment: _noAddress
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              children: _noAddress
                  ? [
                      Text(
                        t.locations.enterAddress,
                        style: context.textStyle.buttonTypo.btn1bold
                            .withColor(context.colors.textColors.white),
                      ),
                    ]
                  : [
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

class UnavailableProductsToFavoritesWidget extends StatelessWidget {
  const UnavailableProductsToFavoritesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kAll16 + AppInsets.kVertical8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            t.cart.notAvailablePresent,
            style: context.textStyle.headingTypo.h3,
          ),
          AppBoxes.kHeight8,
          Text(
            t.cart.addToFavoritesSuggestion,
            style: context.textStyle.textTypo.tx1Medium.withColor(
              context.colors.textColors.secondary,
            ),
          ),
          AppBoxes.kHeight24,
          AppTextButton.accent(
            text: t.cart.transferAndProceed,
            onTap: () {},
          ),
          AppBoxes.kHeight12,
          AppTextButton.secondary(
            text: t.cart.proceedWithoutTransfer,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
