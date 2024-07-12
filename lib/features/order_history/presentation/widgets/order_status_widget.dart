import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/features/order_history/domain/models/recent_order_status.dart';

class OrderStatusWidget extends StatelessWidget {
  const OrderStatusWidget({
    required this.status,
    this.padding = AppInsets.kHorizontal4,
  });

  final RecentOrderStatus status;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final colorStatus = switch (status) {
      RecentOrderStatus.goingTo => colors.buttonColors.accent,
      RecentOrderStatus.onWay => colors.infoColors.blue,
      RecentOrderStatus.received => colors.infoColors.green,
      RecentOrderStatus.cancelled => colors.infoColors.red,
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
