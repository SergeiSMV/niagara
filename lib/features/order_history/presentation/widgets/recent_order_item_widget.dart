import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/order_history/domain/models/recent_order.dart';
import 'package:niagara_app/features/order_history/domain/models/recent_order_status.dart';

class RecentOrderItemWidget extends StatelessWidget {
  const RecentOrderItemWidget({
    super.key,
    required this.order,
  });

  final RecentOrder order;

  void _goToPage(BuildContext context) =>
      context.navigateTo(const OneOrderRoute());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _goToPage(context),
      child: Container(
        width: AppSizes.recentOrderItemWidth,
        margin: AppInsets.kVertical20,
        padding: AppInsets.kAll12,
        decoration: BoxDecoration(
          color: context.colors.mainColors.white,
          borderRadius: AppBorders.kCircular12,
          boxShadow: [
            BoxShadow(
              color: context.colors.textColors.main
                  .withOpacity(AppSizes.kShadowOpacity),
              offset: AppConstants.kShadowDiagonal,
              blurRadius: AppSizes.kGeneral16,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    '${t.recentOrders.orderNumber}${order.orderNumber}',
                    style: context.textStyle.textTypo.tx1SemiBold.copyWith(
                      color: context.colors.buttonColors.accent,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                AppBoxes.kWidth12,
                _OrderStatusWidget(status: order.status),
              ],
            ),
            AppBoxes.kHeight12,
            Text(
              t.locations.deliveryAddress,
              style: context.textStyle.textTypo.tx3Medium.withColor(
                context.colors.textColors.main,
              ),
            ),
            Text(
              order.deliveryAddress,
              style: context.textStyle.textTypo.tx3Medium.withColor(
                context.colors.textColors.secondary,
              ),
            ),
            AppBoxes.kHeight8,
            Text(
              '${t.recentOrders.deliveryDateIn} ${order.deliveryDate}',
              style: context.textStyle.textTypo.tx3Medium.withColor(
                context.colors.textColors.main,
              ),
            ),
            const Spacer(),
            Divider(
              height: AppSizes.kGeneral2,
              thickness: AppSizes.kGeneral1,
              color: context.colors.fieldBordersColors.main.withOpacity(0.3),
            ),
            const Spacer(),
            if (order.status == RecentOrderStatus.received)
              const _BottomButtonsWidget()
            else
              _BottomPriceWidget(price: order.price),
          ],
        ),
      ),
    );
  }
}

class _OrderStatusWidget extends StatelessWidget {
  const _OrderStatusWidget({
    required this.status,
  });

  final RecentOrderStatus status;

  Color _returnColorStatus(BuildContext context) => switch (status) {
        RecentOrderStatus.goingTo => context.colors.buttonColors.accent,
        RecentOrderStatus.onWay => context.colors.infoColors.blue,
        RecentOrderStatus.received => context.colors.infoColors.green,
        RecentOrderStatus.cancelled => context.colors.infoColors.red,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.kHorizontal4 + AppInsets.kVertical6,
      decoration: BoxDecoration(
        borderRadius: AppBorders.kCircular4,
        color: _returnColorStatus(context),
      ),
      child: Text(
        status.toLocale(),
        style: context.textStyle.captionTypo.c1.withColor(
          context.colors.mainColors.white,
        ),
      ),
    );
  }
}

class _BottomPriceWidget extends StatelessWidget {
  const _BottomPriceWidget({
    required this.price,
  });

  final double price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          t.recentOrders.costOfOrder,
          style: context.textStyle.textTypo.tx2SemiBold.withColor(
            context.colors.textColors.main,
          ),
        ),
        Text(
          '$price ${t.common.rub}',
          style: context.textStyle.textTypo.tx2SemiBold.withColor(
            context.colors.textColors.main,
          ),
        ),
      ],
    );
  }
}

class _BottomButtonsWidget extends StatelessWidget {
  const _BottomButtonsWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: AppTextButton.primary(
          text: '',
          onTap: () {},
        )),
        Expanded(child: AppTextButton.secondary()),
      ],
    );
  }
}
