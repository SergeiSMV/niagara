import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/enums/orders_types.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/order_type_Item_widget.dart';

class OrdersTypeButtons extends StatelessWidget {
  const OrdersTypeButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: AppInsets.kAll12,
        child: Row(
          children: [
            ...List.generate(OrdersTypes.values.length, (index) {
              return OrderTypeItemWidget(
                name: OrdersTypes.values[index],
                isSelected: index == 1,
                //OrdersTypes.values[index] == bloc.type,
              );
            }),
            AppBoxes.kWidth12,
          ],
        ),
      ),
    );
  }
}
