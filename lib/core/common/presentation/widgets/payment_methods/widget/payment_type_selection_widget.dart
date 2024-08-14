import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/bloc/payment_method_selection_cubit/payment_method_selection_cubit.dart';
import 'package:niagara_app/core/common/presentation/widgets/payment_methods/widget/payment_method_type_item.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/enums/payment_method_type.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Виджет выбора типа оплаты.
///
/// Показывает `SegmentedButton` с двумя вариантами оплаты: онлайн и курьеру.
class PaymentTypeSelectionWidget extends StatelessWidget {
  const PaymentTypeSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<PaymentMethodSelectionCubit>();
    final bool isOnline = cubit.isOnline;

    void selectOnline() =>
        cubit.selectPaymentMethodType(PaymentMethodType.online);

    void selectCourier() =>
        cubit.selectPaymentMethodType(PaymentMethodType.courier);

    return Padding(
      padding: AppInsets.kAll4,
      child: Row(
        children: [
          PaymentMethodTypeItem(
            title: t.orderPlacing.online,
            selected: isOnline,
            onTap: selectOnline,
            icon: Assets.icons.cardFill,
          ),
          PaymentMethodTypeItem(
            title: t.orderPlacing.byCourier,
            selected: !isOnline,
            onTap: selectCourier,
            icon: Assets.icons.ruble,
          ),
        ],
      ),
    );
  }
}
