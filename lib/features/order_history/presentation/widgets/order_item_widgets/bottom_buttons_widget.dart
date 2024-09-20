import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/enums/order_status.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/order_history/domain/models/user_order.dart';
import 'package:niagara_app/features/order_history/presentation/bloc/rate_order_cubit/rate_order_cubit.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/modals_widgets/cancel_order_modal_widget.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/modals_widgets/rate_modal_widget.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/modals_widgets/repeat_order_modal_widget.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/order_item_widgets/light_button_widget.dart';

class BottomButtonsWidget extends StatelessWidget {
  const BottomButtonsWidget({
    required this.order,
  });

  final UserOrder order;

  /// Открывает модальное окно с оценкой заказа
  Future<void> _showEstimateModal(BuildContext context) async {
    final evaluateOrderCubit = context.read<RateOrderCubit>();

    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      useRootNavigator: true,
      backgroundColor: context.colors.mainColors.white,
      useSafeArea: true,
      builder: (ctx) => BlocProvider.value(
        value: evaluateOrderCubit,
        child: RateModalWidget(orderId: order.id),
      ),
    );
  }

  Future<void> _showRepeatOrderModal(BuildContext context) async {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      useRootNavigator: true,
      backgroundColor: context.colors.mainColors.white,
      useSafeArea: true,
      builder: (ctx) => RepeatOrderModalWidget(
        order: order,
        outerContext: context,
      ),
    );
  }

  Future<void> _showCancelOrderModal(BuildContext context) async {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      useRootNavigator: true,
      backgroundColor: context.colors.mainColors.white,
      useSafeArea: true,
      builder: (ctx) => CancelOrderModalWidget(
        order: order,
        outerContext: context,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (order.orderStatus == OrderStatus.goingTo) ...[
          LightButtonWidget(
            text: t.common.cancel,
            icon: Assets.icons.close,
            onTap: () => _showCancelOrderModal(context),
          ),
        ],
        if (order.orderStatus == OrderStatus.received) ...[
          BlocBuilder<RateOrderCubit, RateOrderState>(
            builder: (context, state) => Row(
              children: [
                ...[
                  if (state == const RateOrderState.initial() ||
                      state == const RateOrderState.loading())
                    order.rating == 0
                        ? Expanded(
                            child: Padding(
                              padding: AppInsets.kRight4,
                              child: LightButtonWidget(
                                text: t.recentOrders.estimate,
                                icon: Assets.icons.star,
                                onTap: () => _showEstimateModal(context),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                ],
                if (order.orderAgain)
                  Expanded(
                    child: LightButtonWidget(
                      text: t.recentOrders.repeat,
                      icon: Assets.icons.repeat,
                      onTap: () => _showRepeatOrderModal(context),
                    ),
                  ),
              ],
            ),
          ),
        ],
        if (order.orderStatus == OrderStatus.cancelled && order.orderAgain) ...[
          LightButtonWidget(
            text: t.recentOrders.repeat,
            icon: Assets.icons.repeat,
            onTap: () => _showRepeatOrderModal(context),
          ),
        ],
      ],
    );
  }
}
