import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/payment_methods/widget/payment_method_selection_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/payment_methods/widget/payment_type_selection_widget.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/enums/payment_method_type.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/order_placing/presentation/bloc/create_order/create_order_cubit.dart';

class OrderPaymentMethodWidget extends StatelessWidget {
  const OrderPaymentMethodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    /// Изменяет метод оплаты в кубите создания заказа.
    void onPaymentMethodChanged(PaymentMethod? method) {
      context.read<OrderCreationCubit>().paymentMethod = method;
    }

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
          Padding(
            padding: AppInsets.kAll4,
            child: Column(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.colors.mainColors.bgCard,
                    borderRadius: AppBorders.kCircular12,
                  ),
                  child: const PaymentTypeSelectionWidget(),
                ),
                AppBoxes.kHeight12,
                PaymentMethodSelectionWidget(
                  onValueChanged: onPaymentMethodChanged,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
