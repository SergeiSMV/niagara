import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/payment_methods/payment_type_and_method_selection_widget.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class OrderPaymentMethodWidget extends StatelessWidget {
  const OrderPaymentMethodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kHorizontal16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBoxes.kHeight16,
          Text(
            t.orderPlacing.paymentMethod,
            style: context.textStyle.textTypo.tx1SemiBold,
          ),
          AppBoxes.kHeight12,
          const PaymentTypeAndMethodSelectionWidget(),
        ],
      ),
    );
  }
}
