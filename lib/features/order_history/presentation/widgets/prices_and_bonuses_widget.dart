import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class PricesAndBonusesWidget extends StatelessWidget {
  const PricesAndBonusesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MediumRowPriceInfoWidget(
          title: t.product(n: 3),
          info: '820 ${t.common.rub}',
        ),
        AppBoxes.kHeight8,
        _SmallRowPriceInfoWidget(
          title: t.cart.discount,
          info: '- 100 ${t.common.rub}',
          infoColor: context.colors.infoColors.red,
        ),
        AppBoxes.kHeight8,
        _SmallRowPriceInfoWidget(
          title: t.cart.promocode,
          info: '- 100 ${t.common.rub}',
          infoColor: context.colors.infoColors.red,
        ),
        AppBoxes.kHeight8,
        _SmallRowPriceInfoWidget(
          title: t.recentOrders.paymentWithBonuses,
          info: '- 200 ${t.common.rub}',
          infoColor: context.colors.infoColors.red,
          titleIcon: Assets.icons.question,
        ),
        AppBoxes.kHeight8,
        _MediumRowPriceInfoWidget(
          title: t.cart.yourBenefits,
          info: '- 400 ${t.common.rub}',
        ),
        AppBoxes.kHeight8,
        Divider(
          thickness: AppSizes.kGeneral1,
          color: context.colors.fieldBordersColors.inactive,
          height: 0,
        ),
        AppBoxes.kHeight8,
        _SmallRowPriceInfoWidget(
          title: t.cart.deliveryFee,
          info: '120 ${t.common.rub}',
          infoColor: context.colors.textColors.main,
          titleIcon: Assets.icons.question,
        ),
        AppBoxes.kHeight8,
        _SmallRowPriceInfoWidget(
          title: t.cart.bonusesAdded,
          info: '+ 80',
          infoColor: context.colors.textColors.main,
          infoIcon: Assets.icons.niagaraPointOrange,
        ),
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
              '420 ${t.common.rub}',
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
