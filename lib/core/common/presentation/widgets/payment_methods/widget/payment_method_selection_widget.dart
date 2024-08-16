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
  const PaymentMethodSelectionWidget({super.key, required this.onValueChanged});

  /// Коллбэк, вызываемый при изменении метода оплаты.
  final void Function(PaymentMethod? method) onValueChanged;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentMethodSelectionCubit,
        PaymentMethodSelectionState>(
      listener: (_, state) => onValueChanged(state.method),
      builder: (_, state) {
        final bool isOnline = state.type == PaymentMethodType.online;

        return Column(
          children: [
            if (!isOnline) ...[
              Text(
                t.orderPlacing.paymentMethodDescription,
                style: context.textStyle.textTypo.tx2Medium,
              ),
              AppBoxes.kHeight12,
            ],
            PaymentMethodsListWidget(
              children: isOnline
                  ? [
                      PaymentMethodTile.fromMethod(
                        method: PaymentMethod.sbp,
                      ),
                      PaymentMethodTile.fromMethod(
                        method: PaymentMethod.bankCard,
                      ),
                      PaymentMethodTile.fromMethod(
                        method: PaymentMethod.sberPay,
                      ),
                    ]
                  : [
                      PaymentMethodTile.fromMethod(
                        method: PaymentMethod.terminal,
                      ),
                      PaymentMethodTile.fromMethod(
                        method: PaymentMethod.cash,
                      ),
                    ],
            ),
          ],
        );
      },
    );
  }
}
