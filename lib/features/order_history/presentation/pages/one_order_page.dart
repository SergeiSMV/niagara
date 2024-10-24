import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/snack_bars/app_snack_bar.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/enums/order_status.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/order_history/domain/models/user_order.dart';
import 'package:niagara_app/features/order_history/presentation/bloc/rate_order_cubit/rate_order_cubit.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/list_products_widget.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/modals_widgets/cancel_order_modal_widget.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/modals_widgets/order_receipt_widget.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/modals_widgets/rate_modal_widget.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/modals_widgets/repeat_order_modal_widget.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/order_data_widget.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/order_status_widget.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/prices_and_bonuses_widget.dart';

/// Экран с одним заказом
@RoutePage()
class OneOrderPage extends StatelessWidget {
  const OneOrderPage({
    super.key,
    required this.order,
    required this.evaluateOrderCubit,
  });

  final UserOrder order;
  final RateOrderCubit evaluateOrderCubit;

  Future<void> _copyOrderNumber(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: order.orderNumber));

    if (!context.mounted) return;
    AppSnackBar.showInfo(context, title: t.recentOrders.orderNumberCopied);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBarWidget(
            title: '${t.recentOrders.orderNumber}${order.orderNumber}',
            actions: [
              InkWell(
                onTap: () => _copyOrderNumber(context),
                child: Padding(
                  padding: AppInsets.kRight16,
                  child: Assets.icons.copy.svg(),
                ),
              ),
            ],
          ),
          const SliverToBoxAdapter(child: AppBoxes.kHeight12),
          SliverToBoxAdapter(
            child: Padding(
              padding: AppInsets.kHorizontal16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${t.recentOrders.created} ${DateFormat('EE. dd.MM, HH:mm', 'ru_RU').format(order.date)}',
                    style: context.textStyle.textTypo.tx2Medium.withColor(
                      context.colors.textColors.main,
                    ),
                  ),
                  OrderStatusWidget(
                    status: order.orderStatus,
                    padding: AppInsets.kHorizontal14,
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: AppBoxes.kHeight28),
          SliverToBoxAdapter(
            child: Padding(
              padding: AppInsets.kHorizontal16,
              child: OrderDataWidget(order: order),
            ),
          ),
          const SliverToBoxAdapter(child: AppBoxes.kHeight32),
          SliverToBoxAdapter(
            child: Padding(
              padding: AppInsets.kHorizontal16,
              child: PricesAndBonusesWidget(order: order),
            ),
          ),
          const SliverToBoxAdapter(child: AppBoxes.kHeight16),
          ListProductsWidget(products: order.products),
          BlocProvider.value(
            value: evaluateOrderCubit,
            child: _BottomButtonsWidget(order: order),
          ),
        ],
      ),
    );
  }
}

/// Кнопки внизу экрана, с учетом статуса заказа
class _BottomButtonsWidget extends StatelessWidget {
  const _BottomButtonsWidget({
    required this.order,
  });

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
  Future<void> _showReceiptModal(BuildContext context) async {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      useRootNavigator: true,
      backgroundColor: context.colors.mainColors.white,
      useSafeArea: true,
      builder: (ctx) => OrderReceiptWidget(order: order),
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
    return SliverToBoxAdapter(
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
                builder: (context, state) {
                  return (state == const RateOrderState.initial() ||
                          state == const RateOrderState.loading())
                      ? AppTextButton.secondary(
                          text: t.recentOrders.evaluateOrder,
                          onTap: () => _showRateModal(context),
                        )
                      : const SizedBox.shrink();
                },
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
}
