import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/bloc/payment_method_selection_cubit/payment_method_selection_cubit.dart';
import 'package:niagara_app/core/common/presentation/widgets/payment_methods/payment_method_tile.dart';
import 'package:niagara_app/core/common/presentation/widgets/payment_methods/payment_method_type_item.dart';
import 'package:niagara_app/core/common/presentation/widgets/payment_methods/payment_methods_list_widget.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/enums/payment_method_type.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class PaymentMethodsSelectionWidget extends StatelessWidget {
  const PaymentMethodsSelectionWidget({super.key});

  void _onPaymentTypeSelected(
    BuildContext context,
    PaymentMethodType type,
  ) =>
      context.read<PaymentMethodSelectionCubit>().selectPaymentMethodType(type);

  void _onOnlinePaymentSelected(
    BuildContext context,
    OnlinePaymentMethod method,
  ) =>
      context
          .read<PaymentMethodSelectionCubit>()
          .selectOnlinePaymentMethod(method);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: context.colors.mainColors.bgCard,
            borderRadius: AppBorders.kCircular12,
          ),
          child: Padding(
            padding: AppInsets.kAll4,
            child: BlocBuilder<PaymentMethodSelectionCubit,
                PaymentMethodSelectionState>(
              builder: (_, state) => Row(
                children: [
                  PaymentMethodTypeItem(
                    title: t.orderPlacing.online,
                    selected: state.isOnline,
                    onTap: () => _onPaymentTypeSelected(
                      context,
                      PaymentMethodType.online,
                    ),
                    icon: Assets.icons.cardFill,
                  ),
                  PaymentMethodTypeItem(
                    title: t.orderPlacing.byCourier,
                    selected: !state.isOnline,
                    onTap: () => _onPaymentTypeSelected(
                      context,
                      PaymentMethodType.courier,
                    ),
                    icon: Assets.icons.ruble,
                  ),
                ],
              ),
            ),
          ),
        ),
        AppBoxes.kHeight12,
        BlocBuilder<PaymentMethodSelectionCubit, PaymentMethodSelectionState>(
          builder: (_, state) => state.maybeWhen(
            courier: (_) => Text(
              t.orderPlacing.paymentMethodDescription,
              style: context.textStyle.textTypo.tx2Medium,
            ),
            online: (method) => PaymentMethodsListWidget(
              children: [
                PaymentMethodTile.sbp(
                  selected: method == OnlinePaymentMethod.sbp,
                  onTap: () => _onOnlinePaymentSelected(
                    context,
                    OnlinePaymentMethod.sbp,
                  ),
                ),
                PaymentMethodTile.bankCard(
                  selected: method == OnlinePaymentMethod.bankCard,
                  onTap: () => _onOnlinePaymentSelected(
                    context,
                    OnlinePaymentMethod.bankCard,
                  ),
                ),
                PaymentMethodTile.sberPay(
                  selected: method == OnlinePaymentMethod.sberPay,
                  onTap: () => _onOnlinePaymentSelected(
                    context,
                    OnlinePaymentMethod.sberPay,
                  ),
                ),
              ],
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}
