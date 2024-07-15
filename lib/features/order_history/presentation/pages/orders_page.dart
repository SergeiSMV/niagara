import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/enums/order_status.dart';
import 'package:niagara_app/features/order_history/domain/models/recent_order.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/orders_type_buttons_widget.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/recent_order_item_widget.dart';

@RoutePage()
class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    const list = [
      RecentOrder(
        orderNumber: 24345,
        deliveryAddress: 'ул. Ростовское ш., дом 22/б',
        deliveryDate: 'Пн. 16.02, 12:00-16:00',
        price: 599,
        status: OrderStatus.cancelled,
      ),
      RecentOrder(
        orderNumber: 24345,
        deliveryAddress: 'ул. Ростовское ш., дом 22/б',
        deliveryDate: 'Пн. 16.02, 12:00-16:00',
        price: 599,
        status: OrderStatus.goingTo,
      ),
      RecentOrder(
        orderNumber: 24345,
        deliveryAddress: 'ул. Ростовское ш., дом 22/б',
        deliveryDate: 'Пн. 16.02, 12:00-16:00',
        price: 599,
        status: OrderStatus.onWay,
      ),
      RecentOrder(
        orderNumber: 24345,
        deliveryAddress: 'ул. Ростовское ш., дом 22/б',
        deliveryDate: 'Пн. 16.02, 12:00-16:00',
        price: 599,
        status: OrderStatus.received,
      ),
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBarWidget(),
          const SliverToBoxAdapter(child: OrdersTypeButtons()),
          SliverPadding(
            padding: AppInsets.kHorizontal16 + AppInsets.kVertical12,
            sliver: SliverList.separated(
              itemCount: list.length,
              itemBuilder: (context, index) => RecentOrderItemWidget(
                order: list[index],
              ),
              separatorBuilder: (_, __) => AppBoxes.kHeight16,
            ),
          ),
        ],
      ),
    );
  }
}
