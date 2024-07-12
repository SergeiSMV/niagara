import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/data_item_widget.dart';

class OrderDataWidget extends StatelessWidget {
  const OrderDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DataItemWidget(
          icon: Assets.icons.card,
          title: t.recentOrders.paymentMethod,
          subtitle: 'Банковской картой',
          paymentStatus: true,
        ),
        AppBoxes.kHeight16,
        DataItemWidget(
          icon: Assets.icons.calendar,
          title: t.recentOrders.deliveryDate,
          subtitle: 'Пн. 16.02, 12:00-16:00',
        ),
        AppBoxes.kHeight16,
        DataItemWidget(
          icon: Assets.icons.mapPoint,
          title: t.locations.deliveryAddress,
          subtitle: 'ул. Уличная, д. 13, кв. 33',
        ),
        AppBoxes.kHeight32,
        DataItemWidget(
          icon: Assets.icons.user,
          title: t.recentOrders.recipient,
          subtitle: 'Иван',
          phone: '+7 (999) 999-99-99',
        ),
        AppBoxes.kHeight16,
        DataItemWidget(
          icon: Assets.icons.comment,
          title: t.recentOrders.comment,
          subtitle: 'Наберите код домофона 4230',
        ),
      ],
    );
  }
}
