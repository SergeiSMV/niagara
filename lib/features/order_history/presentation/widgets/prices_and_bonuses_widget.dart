import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/double_price_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/order_history/domain/models/user_order.dart';

class PricesAndBonusesWidget extends StatelessWidget {
  const PricesAndBonusesWidget({
    super.key,
    required this.order,
  });

  final UserOrder order;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MediumRowPriceInfoWidget(
          title: t.product(n: order.products.length),
          info: '${order.orderProductsSum.priceString} ${t.common.rub}',
        ),
        if (order.sumDiscont > 0) ...[
          AppBoxes.kHeight8,
          _SmallRowPriceInfoWidget(
            title: t.cart.discount,
            info: '- ${order.sumDiscont.priceString} ${t.common.rub}',
            infoColor: context.colors.infoColors.red,
          ),
        ],
        if (order.promoCodeSum > 0) ...[
          AppBoxes.kHeight8,
          _SmallRowPriceInfoWidget(
            title: t.cart.promocode,
            info: '- ${order.promoCodeSum.priceString} ${t.common.rub}',
            infoColor: context.colors.infoColors.red,
          ),
        ],
        if (order.bonusesPay > 0) ...[
          AppBoxes.kHeight8,
          _SmallRowPriceInfoWidget(
            title: t.recentOrders.paymentWithBonuses,
            info: '- ${order.bonusesPay.priceString} ${t.common.rub}',
            infoColor: context.colors.infoColors.red,
            titleIcon: Assets.icons.question,
          ),
        ],
        if (order.totalBenefit > 0) ...[
          AppBoxes.kHeight8,
          _MediumRowPriceInfoWidget(
            title: t.cart.yourBenefits,
            info: '- ${order.totalBenefit.priceString} ${t.common.rub}',
          ),
        ],
        if (order.sumDelivery > 0 || order.bonusesAdd > 0) ...[
          AppBoxes.kHeight8,
          Divider(
            thickness: AppSizes.kGeneral1,
            color: context.colors.fieldBordersColors.inactive,
            height: 0,
          ),
        ],
        if (order.sumDelivery > 0) ...[
          AppBoxes.kHeight8,
          _SmallRowPriceInfoWidget(
            title: t.cart.deliveryFee,
            info: '${order.sumDelivery.priceString} ${t.common.rub}',
            infoColor: context.colors.textColors.main,
            titleIcon: Assets.icons.question,
          ),
        ],
        if (order.bonusesAdd > 0) ...[
          AppBoxes.kHeight8,
          _SmallRowPriceInfoWidget(
            title: t.cart.bonusesAdded,
            info: '+ ${order.bonusesAdd.priceString}',
            infoColor: context.colors.textColors.main,
            infoIcon: Assets.icons.niagaraPointOrange,
          ),
        ],
        AppBoxes.kHeight12,
        Divider(
          thickness: AppSizes.kGeneral1,
          color: context.colors.fieldBordersColors.inactive,
          height: 0,
        ),
        AppBoxes.kHeight12,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.cart.total,
              style: context.textStyle.headingTypo.h3.withColor(
                context.colors.textColors.main,
              ),
            ),
            Text(
              '${order.totalSum.priceString} ${t.common.rub}',
              style: context.textStyle.headingTypo.h3.withColor(
                context.colors.textColors.main,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MediumRowPriceInfoWidget extends StatelessWidget {
  const _MediumRowPriceInfoWidget({
    required this.title,
    required this.info,
  });

  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: context.textStyle.textTypo.tx2SemiBold
              .withColor(context.colors.textColors.main),
        ),
        const Spacer(),
        Text(
          info,
          style: context.textStyle.textTypo.tx2SemiBold
              .withColor(context.colors.textColors.main),
        ),
      ],
    );
  }
}

class _SmallRowPriceInfoWidget extends StatelessWidget {
  const _SmallRowPriceInfoWidget({
    required this.title,
    required this.info,
    required this.infoColor,
    this.titleIcon,
    this.infoIcon,
  });

  final String title;
  final String info;
  final SvgGenImage? titleIcon;
  final SvgGenImage? infoIcon;
  final Color infoColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: context.textStyle.descriptionTypo.des2
              .withColor(context.colors.textColors.main),
        ),
        AppBoxes.kWidth8,
        if (titleIcon != null)
          titleIcon!.svg(
            width: AppSizes.kIconSmall,
            height: AppSizes.kIconSmall,
          ),
        const Spacer(),
        Text(
          info,
          style: context.textStyle.descriptionTypo.des2.withColor(infoColor),
        ),
        if (infoIcon != null) ...[
          AppBoxes.kWidth6,
          infoIcon!.svg(
            width: AppSizes.kIconSmall,
            height: AppSizes.kIconSmall,
          ),
        ],
      ],
    );
  }
}
