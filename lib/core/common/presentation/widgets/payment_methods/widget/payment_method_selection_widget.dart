import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/bloc/payment_method_selection_cubit/payment_method_selection_cubit.dart';
import 'package:niagara_app/core/common/presentation/widgets/payment_methods/widget/payment_method_tile.dart';
import 'package:niagara_app/core/common/presentation/widgets/payment_methods/widget/payment_methods_list_widget.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/enums/payment_method_type.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Виджет выбора метода оплаты.
///
/// Отображает список методов оплаты в зависимости от выбранного типа оплаты.
class PaymentMethodSelectionWidget extends StatelessWidget {
  const PaymentMethodSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<PaymentMethodSelectionCubit>();

    void selectMethod(PaymentMethod method) =>
        cubit.selectPaymentMethod(method);

    final PaymentMethod? method = cubit.state.method;

    return Column(
      children: [
        if (!cubit.isOnline) ...[
          Text(
            t.orderPlacing.paymentMethodDescription,
            style: context.textStyle.textTypo.tx2Medium,
          ),
          AppBoxes.kHeight12,
        ],
        PaymentMethodsListWidget(
          children: cubit.isOnline
              ? [
                  PaymentMethodTile.sbp(
                    selected: method == PaymentMethod.sbp,
                    onTap: () => selectMethod(
                      PaymentMethod.sbp,
                    ),
                  ),
                  PaymentMethodTile.bankCard(
                    selected: method == PaymentMethod.bankCard,
                    onTap: () => selectMethod(
                      PaymentMethod.bankCard,
                    ),
                  ),
                  PaymentMethodTile.sberPay(
                    selected: method == PaymentMethod.sberPay,
                    onTap: () => selectMethod(
                      PaymentMethod.sberPay,
                    ),
                  ),
                ]
              : [
                  PaymentMethodTile.terminal(
                    onTap: () => selectMethod(PaymentMethod.terminal),
                    selected: method == PaymentMethod.terminal,
                  ),
                  PaymentMethodTile.cash(
                    onTap: () => selectMethod(PaymentMethod.cash),
                    selected: method == PaymentMethod.cash,
                  ),
                ],
        ),
      ],
    );
  }
}
