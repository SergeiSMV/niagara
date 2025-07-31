import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common/presentation/widgets/buttons/app_text_button.dart';
import '../../../../../core/utils/constants/app_boxes.dart';
import '../../../../../core/utils/constants/app_insets.dart';
import '../../../../../core/utils/enums/order_status.dart';
import '../../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../../core/utils/gen/strings.g.dart';
import '../../../domain/models/user_order.dart';
import '../../bloc/rate_order_cubit/rate_order_cubit.dart';
import '../modals_widgets/cancel_order_modal_widget.dart';
import '../modals_widgets/order_receipt_widget.dart';
import '../modals_widgets/rate_modal_widget.dart';
import '../modals_widgets/repeat_order_modal_widget.dart';

/// Кнопки внизу экрана, с учетом статуса заказа
class BottomButtonsWidget extends StatelessWidget {
  const BottomButtonsWidget({
    required this.order,
    super.key,
  });

  /// Заказ
  final UserOrder order;

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
        child: RateModalWidget(orderId: order.id),
      ),
    );
  }

  /// Открывает модальное окно с оценкой заказа
  Future<void> _showReceiptModal(BuildContext context) async =>
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        useRootNavigator: true,
        backgroundColor: context.colors.mainColors.white,
        useSafeArea: true,
        builder: (ctx) => OrderReceiptWidget(order: order),
      );

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
  Widget build(BuildContext context) => SliverToBoxAdapter(
        child: Padding(
          padding: AppInsets.kHorizontal16,
          child: Column(
            children: [
              AppBoxes.kHeight24,

              /// Отменить заказ (status = собирается)
              if (order.orderStatus == OrderStatus.goingTo) ...[
                AppTextButton.secondary(
                  text: t.recentOrders.cancelOrder,
                  onTap: () => _showCancelOrderModal(context),
                ),
              ],

              /// Связаться с водителем (status = в пути)
              if (order.orderStatus == OrderStatus.onWay) ...[
                AppTextButton.primary(
                  text: t.recentOrders.contactDriver,
                  onTap: () {},
                ),
              ],

              /// Повторить заказ (status = Получен)
              if (order.orderStatus == OrderStatus.received) ...[
                if (order.orderAgain) ...[
                  AppTextButton.primary(
                    text: t.recentOrders.repeatOrder,
                    onTap: () => _showRepeatOrderModal(context),
                  ),
                  AppBoxes.kHeight12,
                ],

                /// Оценить заказ
                BlocBuilder<RateOrderCubit, RateOrderState>(
                  builder: (context, state) =>
                      (state == const RateOrderState.initial() ||
                              state == const RateOrderState.loading())
                          ? AppTextButton.secondary(
                              text: t.recentOrders.evaluateOrder,
                              onTap: () => _showRateModal(context),
                            )
                          : const SizedBox.shrink(),
                ),
              ],

              /// Электронный чек
              if (order.paymentCompleted) ...[
                AppBoxes.kHeight12,
                AppTextButton.secondary(
                  text: t.recentOrders.electronicReceipt,
                  onTap: () => _showReceiptModal(context),
                ),
              ],

              /// Повторить заказ (status = Отменен)
              if (order.orderStatus == OrderStatus.cancelled &&
                  order.orderAgain) ...[
                AppBoxes.kHeight12,
                AppTextButton.primary(
                  text: t.recentOrders.repeatOrder,
                  onTap: () => _showRepeatOrderModal(context),
                ),
              ],
              AppBoxes.kHeight24,
            ],
          ),
        ),
      );
}
