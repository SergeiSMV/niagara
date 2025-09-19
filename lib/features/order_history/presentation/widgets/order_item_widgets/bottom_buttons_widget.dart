import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/constants/app_boxes.dart';
import '../../../../../core/utils/enums/order_status.dart';
import '../../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../../core/utils/gen/assets.gen.dart';
import '../../../../../core/utils/gen/strings.g.dart';
import '../../../domain/models/user_order.dart';
import '../../bloc/rate_order_cubit/rate_order_cubit.dart';
import '../modals_widgets/cancel_order_modal_widget.dart';
import '../modals_widgets/rate_modal_widget.dart';
import '../modals_widgets/repeat_order_modal_widget.dart';
import 'light_button_widget.dart';
import 'order_raiting_widget.dart';

/// Виджет кнопок в нижней части заказа
class BottomButtonsWidget extends StatelessWidget {
  const BottomButtonsWidget({
    required this.order,
    this.onSortUpdate,
    super.key,
  });

  /// Заказ
  final UserOrder order;

  /// Callback для обновления сортировки
  final VoidCallback? onSortUpdate;

  /// Открывает модальное окно с оценкой заказа
  Future<void> _showRateModal(BuildContext context) async {
    final cubit = context.read<RateOrderCubit>();

    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      useRootNavigator: true,
      backgroundColor: context.colors.mainColors.white,
      useSafeArea: true,
      builder: (ctx) => BlocProvider.value(
        value: cubit,
        child: RateModalWidget(
          orderId: order.id,
          onSortUpdate: onSortUpdate,
        ),
      ),
    );
  }

  /// Открывает модальное окно для повтора заказа
  Future<void> _showRepeatOrderModal(BuildContext context) async =>
      showModalBottomSheet(
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

  /// Открывает модальное окно для отмены заказа
  Future<void> _showCancelOrderModal(BuildContext context) async =>
      showModalBottomSheet(
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

  @override
  Widget build(BuildContext context) => Column(
        children: [
          if (order.orderStatus == OrderStatus.goingTo.toLocale()) ...[
            LightButtonWidget(
              text: t.common.cancel,
              icon: Assets.icons.close,
              onTap: () => _showCancelOrderModal(context),
            ),
          ],
          if (order.orderStatus == OrderStatus.received.toLocale()) ...[
            BlocBuilder<RateOrderCubit, RateOrderState>(
              builder: (context, state) => Row(
                children: [
                  ...[
                    if (state == const RateOrderState.initial() ||
                        state == const RateOrderState.loading())
                      order.rating == 0
                          ? Expanded(
                              child: LightButtonWidget(
                                text: t.recentOrders.rate,
                                icon: Assets.icons.star,
                                onTap: () => _showRateModal(context),
                              ),
                            )
                          : Expanded(
                              child: OrderRaitingWidget(rating: order.rating),
                            ),
                  ],
                  if (order.orderAgain) ...[
                    AppBoxes.kWidth4,
                    Expanded(
                      child: LightButtonWidget(
                        text: t.recentOrders.repeat,
                        icon: Assets.icons.repeat,
                        onTap: () => _showRepeatOrderModal(context),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
          if (order.orderStatus == OrderStatus.cancelled.toLocale() &&
              order.orderAgain) ...[
            LightButtonWidget(
              text: t.recentOrders.repeat,
              icon: Assets.icons.repeat,
              onTap: () => _showRepeatOrderModal(context),
            ),
          ],
        ],
      );
}
