import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/enums/order_status.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/order_history/domain/models/user_order.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/list_products_widget.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/order_data_widget.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/order_status_widget.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/prices_and_bonuses_widget.dart';

@RoutePage()
class OneOrderPage extends StatelessWidget {
  const OneOrderPage({
    super.key,
    required this.order,
  });

  final UserOrder order;

  Widget _returnBottomButtons() => switch (order.orderStatus) {
        OrderStatus.cancelled => AppTextButton.secondary(
            text: "t.recentOrders.cancelOrder",
            onTap: () {},
          ),
        OrderStatus.goingTo => Padding(
            padding: AppInsets.kHorizontal16 + AppInsets.kVertical24,
            child: AppTextButton.secondary(
              text: t.recentOrders.cancelOrder,
              onTap: () {},
            ),
          ),
        OrderStatus.onWay => AppTextButton.secondary(
            text: "t.recentOrders.markAsDelivered",
            onTap: () {},
          ),
        OrderStatus.received => AppTextButton.secondary(
            text: "t.recentOrders.markAsInProgress",
            onTap: () {},
          ),
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBarWidget(
            title: '${t.recentOrders.orderNumber}${order.orderNumber}',
            actions: [
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: AppInsets.kRight16,
                  child: Assets.icons.copy.svg(),
                ),
              ),
            ],
          ),
          const SliverToBoxAdapter(child: AppBoxes.kHeight12),
          SliverToBoxAdapter(
            child: Padding(
              padding: AppInsets.kHorizontal16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${t.recentOrders.created} ${DateFormat('EE. dd.MM, HH:mm', 'ru_RU').format(order.date)}',
                    style: context.textStyle.textTypo.tx2Medium.withColor(
                      context.colors.textColors.main,
                    ),
                  ),
                  OrderStatusWidget(
                    status: order.orderStatus,
                    padding: AppInsets.kHorizontal14,
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: AppBoxes.kHeight28),
          SliverToBoxAdapter(
            child: Padding(
              padding: AppInsets.kHorizontal16,
              child: OrderDataWidget(order: order),
            ),
          ),
          const SliverToBoxAdapter(child: AppBoxes.kHeight32),
          SliverToBoxAdapter(
            child: Padding(
              padding: AppInsets.kHorizontal16,
              child: PricesAndBonusesWidget(order: order),
            ),
          ),
          const SliverToBoxAdapter(child: AppBoxes.kHeight16),
          ListProductsWidget(products: order.products),
          const SliverToBoxAdapter(child: BottomButtonsWidget()),
        ],
      ),
    );
  }
}

class BottomButtonsWidget extends StatelessWidget {
  const BottomButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kHorizontal16,
      child: Column(
        children: [
          AppBoxes.kHeight24,
          AppTextButton.secondary(
            text: t.recentOrders.cancelOrder,
            onTap: () {},
          ),
          AppBoxes.kHeight24,
        ],
      ),
    );
  }
}

class BottomButtonsWhenStatusIsGoingTo extends StatelessWidget {
  const BottomButtonsWhenStatusIsGoingTo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kHorizontal16 + AppInsets.kVertical24,
      child: AppTextButton.secondary(
        text: t.recentOrders.cancelOrder,
        onTap: () {},
      ),
    );
  }
}
