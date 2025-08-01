import 'package:flutter/material.dart';
import '../../../../core/utils/constants/app_borders.dart';
import '../../../../core/utils/constants/app_insets.dart';
import '../../../../core/utils/enums/order_status.dart';
import '../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../core/utils/extensions/text_style_ext.dart';
import '../../domain/models/user_order.dart';

class OrderStatusWidget extends StatelessWidget {
  const OrderStatusWidget({
    required this.status,
    required this.order,
    super.key,
    this.padding = AppInsets.kHorizontal4,
  });

  final OrderStatus status;
  final UserOrder order;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    debugPrint('orderStatusHex: ${order.orderStatusHex}');
    final colors = context.colors;

    final colorStatus = switch (status) {
      OrderStatus.goingTo => colors.buttonColors.accent,
      OrderStatus.onWay => colors.infoColors.blue,
      OrderStatus.received => colors.infoColors.green,
      OrderStatus.cancelled => colors.infoColors.red,
    };

    return Container(
      padding: padding + AppInsets.kVertical6,
      decoration: BoxDecoration(
        borderRadius: AppBorders.kCircular4,
        color: colorStatus,
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
