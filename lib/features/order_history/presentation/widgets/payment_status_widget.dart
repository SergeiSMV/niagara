import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/features/order_history/domain/models/payment_statuses.dart';

class PaymentStatusWidget extends StatelessWidget {
  const PaymentStatusWidget({
    super.key,
    required this.status,
  });

  final PaymentStatuses status;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors.infoColors;

    final widgetColor = switch (status) {
      PaymentStatuses.paidFor => colors.lightGreen,
      PaymentStatuses.notPaidFor => colors.lightRed,
    };

    final textColor = switch (status) {
      PaymentStatuses.paidFor => colors.green,
      PaymentStatuses.notPaidFor => colors.red,
    };

    return Container(
      padding: AppInsets.kVertical2 + AppInsets.kHorizontal4,
      decoration: BoxDecoration(
        borderRadius: AppBorders.kCircular4,
        color: widgetColor,
      ),
      child: Text(
        status.toLocale(),
        style: context.textStyle.textTypo.tx3SemiBold.withColor(textColor),
      ),
    );
  }
}
