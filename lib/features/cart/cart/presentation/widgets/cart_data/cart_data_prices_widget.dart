import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';
import 'package:niagara_app/features/cart/cart/presentation/widgets/cart_data/cart_data_bonuses_added_widget.dart';
import 'package:niagara_app/features/cart/cart/presentation/widgets/cart_data/cart_data_delivery_widget.dart';
import 'package:niagara_app/features/cart/cart/presentation/widgets/cart_data/cart_data_widget.dart';

class CartDataPricesWidget extends StatelessWidget {
  const CartDataPricesWidget({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kHorizontal16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.cart.yourCart,
            style: context.textStyle.textTypo.tx1SemiBold
                .withColor(context.colors.textColors.main),
          ),
          AppBoxes.kHeight8,
          CartDataWidget(
            title: t.product(n: cart.cartData.productsCount),
            data: cart.cartData.productsTotalSum,
            isBold: true,
          ),
          CartDataWidget(
            title: t.cart.tarePrice,
            data: cart.cartData.tareSum,
          ),
          CartDataWidget(
            title: t.cart.discount,
            data: cart.cartData.discount,
          ),
          CartDataWidget(
            title: t.cart.promocode,
            data: cart.cartData.promocode,
          ),
          CartDataWidget(
            title: t.cart.bonusesPay,
            data: cart.cartData.bonusesPayment,
          ),
          CartDataWidget(
            title: t.cart.yourBenefits,
            data: cart.cartData.benefits,
            isBold: true,
          ),
          Divider(
            height: AppSizes.kGeneral16,
            thickness: AppSizes.kGeneral1,
            color: context.colors.otherColors.separator30,
          ),
          CartDataDeliveryWidget(cart: cart),
          CartDataBonusesAddedWidget(cart: cart),
          Divider(
            height: AppSizes.kGeneral16,
            thickness: AppSizes.kGeneral1,
            color: context.colors.otherColors.separator30,
          ),
          _CartTotalPriceWidget(cart: cart),
        ],
      ),
    );
  }
}

class _CartTotalPriceWidget extends StatelessWidget {
  const _CartTotalPriceWidget({
    required this.cart,
  });

  final Cart cart;

  void _gotToVipPage(BuildContext context) => context.navigateTo(
        const LoyaltyProgramWrapper(children: [VipRoute()]),
      );

  @override
  Widget build(BuildContext context) {
    final bool showVip = cart.cartData.vipPrice != 0;

    return GestureDetector(
      onTap: showVip ? () => _gotToVipPage(context) : null,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.infoColors.green,
          borderRadius: AppBorders.kCircular12,
        ),
        child: Padding(
          padding: AppInsets.kAll12,
          child: Column(
            children: [
              _InfoTotalPriceWidget(
                title: t.cart.total,
                data: cart.cartData.totalPrice,
                textStyle: context.textStyle.headingTypo.h3,
              ),
              if (showVip) ...[
                AppBoxes.kHeight8,
                _InfoTotalPriceWidget(
                  title: t.catalog.withVIP,
                  data: cart.cartData.vipPrice,
                  textStyle: context.textStyle.textTypo.tx3Medium,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoTotalPriceWidget extends StatelessWidget {
  const _InfoTotalPriceWidget({
    required this.title,
    required this.data,
    required this.textStyle,
  });

  final String title;
  final double data;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    final textColor = context.colors.mainColors.white;

    return Row(
      children: [
        Text(
          title,
          style: textStyle.withColor(textColor),
        ),
        const Spacer(),
        Text(
          '${data.toInt()} ${t.common.rub}',
          style: textStyle.withColor(textColor),
        ),
      ],
    );
  }
}
