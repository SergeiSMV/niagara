import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/enums/orders_payment_types.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/order_history/domain/models/user_order.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/data_item_widget.dart';

class OrderDataWidget extends StatelessWidget {
  const OrderDataWidget({
    super.key,
    required this.order,
  });

  final UserOrder order;

  String _returnFormattedDateDelivery() {
    final dayAndMonth =
        DateFormat('EE. dd.MM', 'ru_RU').format(order.dateDelivery);
    final timeBegin = DateFormat('HH:mm').format(order.timeBegin);
    final timeEnd = DateFormat('HH:mm').format(order.timeEnd);
    return '$dayAndMonth, $timeBegin-$timeEnd';
  }

  String _formatPhoneNumber() {
    final cleanedPhoneNumber =
        order.customerPhone.replaceAll(RegExp(r'[^0-9]'), '');

    if (cleanedPhoneNumber.length != 11) {
      return order.customerPhone;
    }

    // Разбиваем номер на части
    final countryCode = cleanedPhoneNumber.substring(0, 1);
    final areaCode = cleanedPhoneNumber.substring(1, 4);
    final prefix = cleanedPhoneNumber.substring(4, 7);
    final lineNumber = cleanedPhoneNumber.substring(7, 9);
    final extension = cleanedPhoneNumber.substring(9);

    // Формируем отформатированный номер
    final formattedPhoneNumber =
        '${countryCode == '7' ? '+' : ''}$countryCode ($areaCode) $prefix-$lineNumber-$extension';

    return formattedPhoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (order.paymentType != OrdersPaymentTypes.unknown)
          DataItemWidget(
            icon: Assets.icons.card,
            title: t.recentOrders.paymentMethod,
            subtitle: order.paymentType.toLocale(),
            paymentCompleted: order.paymentCompleted,
          ),
        AppBoxes.kHeight16,
        DataItemWidget(
          icon: Assets.icons.calendar,
          title: t.recentOrders.deliveryDate,
          subtitle: _returnFormattedDateDelivery(),
        ),
        AppBoxes.kHeight16,
        DataItemWidget(
          icon: Assets.icons.mapPoint,
          title: t.locations.deliveryAddress,
          subtitle: order.locationName,
        ),
        AppBoxes.kHeight32,
        DataItemWidget(
          icon: Assets.icons.user,
          title: t.recentOrders.recipient,
          subtitle: order.customerName,
          phone: _formatPhoneNumber(),
        ),
        AppBoxes.kHeight16,
        DataItemWidget(
          icon: Assets.icons.comment,
          title: t.recentOrders.comment,
          subtitle: order.description,
        ),
      ],
    );
  }
}
