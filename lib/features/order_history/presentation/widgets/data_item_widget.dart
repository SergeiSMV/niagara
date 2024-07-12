import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/order_history/domain/models/payment_statuses.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/payment_status_widget.dart';

class DataItemWidget extends StatelessWidget {
  const DataItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.phone,
    this.paymentStatus = false,
  });

  final SvgGenImage icon;
  final String title;
  final String subtitle;
  final String? phone;
  final bool paymentStatus;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icon.svg(
          width: AppSizes.kIconMedium,
          height: AppSizes.kIconMedium,
        ),
        AppBoxes.kWidth8,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBoxes.kHeight1,
              Text(
                title,
                style: context.textStyle.textTypo.tx2SemiBold
                    .withColor(context.colors.textColors.main),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    subtitle,
                    style: context.textStyle.descriptionTypo.des2
                        .withColor(context.colors.textColors.main),
                  ),
                  if (paymentStatus)
                    const PaymentStatusWidget(status: PaymentStatuses.paidFor),
                ],
              ),
              if ((phone ?? '').isNotEmpty)
                Text(
                  phone!,
                  style: context.textStyle.descriptionTypo.des2
                      .withColor(context.colors.textColors.main),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
