import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class PaymentStatusWidget extends StatelessWidget {
  const PaymentStatusWidget({
    super.key,
    required this.paymentCompleted,
  });

  final bool paymentCompleted;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors.infoColors;

    final widgetColor = paymentCompleted ? colors.lightGreen : colors.lightRed;

    final textColor = paymentCompleted ? colors.green : colors.red;

    final statusText = paymentCompleted
        ? t.recentOrders.paymentStatuses.paidFor
        : t.recentOrders.paymentStatuses.notPaidFor;

    return Container(
      padding: AppInsets.kVertical2 + AppInsets.kHorizontal4,
      decoration: BoxDecoration(
        borderRadius: AppBorders.kCircular4,
        color: widgetColor,
      ),
      child: Text(
        statusText,
        style: context.textStyle.textTypo.tx3SemiBold.withColor(textColor),
      ),
    );
  }
}
