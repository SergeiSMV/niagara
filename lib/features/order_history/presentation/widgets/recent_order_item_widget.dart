import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/enums/order_status.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/order_history/domain/models/recent_order.dart';
import 'package:niagara_app/features/order_history/domain/models/user_order.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/light_button_widget.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/order_status_widget.dart';

class RecentOrderItemWidget extends StatelessWidget {
  const RecentOrderItemWidget({
    super.key,
    required this.order,
    this.inHorizontalList = false,
  });

  final UserOrder order;
  final bool inHorizontalList;

  void _goToOrderPage(BuildContext context) => context.navigateTo(
        ProfileWrapper(
          children: [
            const ProfileRoute(),
            const OrdersRoute(),
            // OneOrderRoute(order: order),
          ],
        ),
      );

  Widget _returnBottomWidget() => switch (order.ordersStatus) {
        OrderStatus.goingTo => _BottomPriceWidget(price: order.ordersTotalSum),
        OrderStatus.onWay => _BottomPriceWidget(price: order.ordersTotalSum),
        OrderStatus.received => const _BottomButtonsWidget(),
        OrderStatus.cancelled => LightButtonWidget(
            text: t.recentOrders.repeat,
            icon: Assets.icons.repeat,
            onTap: () {},
          ),
      };

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _goToOrderPage(context),
      child: Container(
        width: inHorizontalList ? AppSizes.recentOrderItemWidth : null,
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
                    '${t.recentOrders.orderNumber}${order.ordersDescription}',
                    style: context.textStyle.textTypo.tx1SemiBold.copyWith(
                      color: context.colors.buttonColors.accent,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                AppBoxes.kWidth12,
                OrderStatusWidget(status: order.ordersStatus),
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
              order.ordersLocationName,
              style: context.textStyle.textTypo.tx3Medium.withColor(
                context.colors.textColors.secondary,
              ),
            ),
            AppBoxes.kHeight8,
            Text(
              '${t.recentOrders.deliveryDateIn} ${order.ordersDateDelivery}',
              style: context.textStyle.textTypo.tx3Medium.withColor(
                context.colors.textColors.main,
              ),
            ),
            if (inHorizontalList) const Spacer() else AppBoxes.kHeight12,
            Divider(
              height: AppSizes.kGeneral2,
              thickness: AppSizes.kGeneral1,
              color: context.colors.fieldBordersColors.main.withOpacity(0.3),
            ),
            if (inHorizontalList) const Spacer() else AppBoxes.kHeight12,
            _returnBottomWidget(),
          ],
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
          child: LightButtonWidget(
            text: t.recentOrders.estimate,
            icon: Assets.icons.star,
            onTap: () {},
          ),
        ),
        AppBoxes.kWidth4,
        Expanded(
          child: LightButtonWidget(
            text: t.recentOrders.repeat,
            icon: Assets.icons.repeat,
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
