import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/constants/app_boxes.dart';
import '../../../../core/utils/constants/app_insets.dart';
import '../../../../core/utils/enums/orders_types.dart';
import '../bloc/orders_bloc/orders_bloc.dart';
import 'order_type_item_widget.dart';

/// Виджет кнопок для сортировки заказов (активные, полученные, отмененные)
class OrdersTypeButtons extends StatelessWidget {
  const OrdersTypeButtons({super.key});

  @override
  Widget build(BuildContext context) {
    /// Блок для управления сортировкой заказов
    final bloc = context.read<OrdersBloc>();

    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: AppInsets.kAll12,
          child: Row(
            children: [
              ...List.generate(
                OrdersTypes.values.length,
                (index) => OrderTypeItemWidget(
                  name: OrdersTypes.values[index],
                  isSelected: OrdersTypes.values[index] == bloc.sort,
                ),
              ),
              AppBoxes.kWidth12,
            ],
          ),
        ),
      ),
    );
  }
}
