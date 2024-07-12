import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/order_history/domain/models/recent_order.dart';
import 'package:niagara_app/features/order_history/domain/models/recent_order_status.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/recent_order_item_widget.dart';

class RecentOrdersListWidget extends StatelessWidget {
  const RecentOrdersListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const list = [
      RecentOrder(
        orderNumber: 24345,
        deliveryAddress: 'ул. Ростовское ш., дом 22/б',
        deliveryDate: 'Пн. 16.02, 12:00-16:00',
        price: 599,
        status: RecentOrderStatus.cancelled,
      ),
      RecentOrder(
        orderNumber: 24345,
        deliveryAddress: 'ул. Ростовское ш., дом 22/б',
        deliveryDate: 'Пн. 16.02, 12:00-16:00',
        price: 599,
        status: RecentOrderStatus.goingTo,
      ),
      RecentOrder(
        orderNumber: 24345,
        deliveryAddress: 'ул. Ростовское ш., дом 22/б',
        deliveryDate: 'Пн. 16.02, 12:00-16:00',
        price: 599,
        status: RecentOrderStatus.onWay,
      ),
      RecentOrder(
        orderNumber: 24345,
        deliveryAddress: 'ул. Ростовское ш., дом 22/б',
        deliveryDate: 'Пн. 16.02, 12:00-16:00',
        price: 599,
        status: RecentOrderStatus.received,
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBoxes.kHeight32,
        Padding(
          padding: AppInsets.kHorizontal16,
          child: Text(
            t.recentOrders.recentOrders,
            style: context.textStyle.headingTypo.h3
                .withColor(context.colors.textColors.main),
          ),
        ),
        SizedBox(
          height: AppSizes.kListItemsHeight,
          child: ListView.separated(
            padding: AppInsets.kHorizontal16,
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) => RecentOrderItemWidget(
              order: list[index],
            ),
            separatorBuilder: (_, __) => AppBoxes.kWidth12,
          ),
        ),
      ],
    );
  }
}
