// ignore_for_file: always_put_required_named_parameters_first

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/common/presentation/widgets/app_bar.dart';
import '../../../../core/common/presentation/widgets/buttons/app_text_button.dart';
import '../../../../core/common/presentation/widgets/snack_bars/app_snack_bar.dart';
import '../../../../core/utils/constants/app_boxes.dart';
import '../../../../core/utils/constants/app_insets.dart';
import '../../../../core/utils/enums/order_status.dart';
import '../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../core/utils/extensions/text_style_ext.dart';
import '../../../../core/utils/gen/assets.gen.dart';
import '../../../../core/utils/gen/strings.g.dart';
import '../../domain/models/user_order.dart';
import '../bloc/rate_order_cubit/rate_order_cubit.dart';
import '../widgets/list_products_widget.dart';
import '../widgets/modals_widgets/cancel_order_modal_widget.dart';
import '../widgets/modals_widgets/order_receipt_widget.dart';
import '../widgets/modals_widgets/rate_modal_widget.dart';
import '../widgets/modals_widgets/repeat_order_modal_widget.dart';
import '../widgets/order_data_widget.dart';
import '../widgets/order_status_widget.dart';
import '../widgets/prices_and_bonuses_widget.dart';

/// Экран с одним заказом
@RoutePage()
class OneOrderPage extends StatelessWidget {
  const OneOrderPage({
    required this.order,
    required this.evaluateOrderCubit,
    super.key,
    this.isFromPush = false,
  });

  /// Заказ
  final UserOrder order;

  /// Кубит для оценки заказа
  final RateOrderCubit evaluateOrderCubit;

  /// Флаг, что заказ открыт из Push
  final bool isFromPush;

  Future<void> _copyOrderNumber(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: order.orderNumber));

    if (!context.mounted) return;
    AppSnackBar.showInfo(context, title: t.recentOrders.orderNumberCopied);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
                      order: order,
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
              child: _BottomButtonsWidget(
                order: order,
                isFromPush: isFromPush,
              ),
            ),
          ],
        ),
      );
}

/// Кнопки внизу экрана, с учетом статуса заказа
class _BottomButtonsWidget extends StatelessWidget {
  const _BottomButtonsWidget({
    required this.order,
    required this.isFromPush,
  });

  /// Заказ
  final UserOrder order;

  /// Флаг, что заказ открыт из Push
  final bool isFromPush;

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

  /// Обработчик открытия заказа из Push
  Future<void> _openOrderFromPush(BuildContext context) async {
    if (isFromPush && order.rating == 0) {
      _showRateModal(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Вызываем _openOrderFromPush после завершения построения виджета
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _openOrderFromPush(context);
    });
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
            if (order.orderStatus == OrderStatus.onWay.toLocale()) ...[
              AppTextButton.primary(
                text: t.recentOrders.contactDriver,
                onTap: () {},
              ),
            ],

            /// Повторить заказ (status = Получен)
            if (order.orderStatus == OrderStatus.received.toLocale()) ...[
              if (order.orderAgain) ...[
                AppTextButton.primary(
                  text: t.recentOrders.repeatOrder,
                  onTap: () => _showRepeatOrderModal(context),
                ),
                AppBoxes.kHeight12,
              ],

              /// Оценить заказ
              if (order.rating == 0) ...[
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
                AppBoxes.kHeight12,
              ],
            ],

            /// Электронный чек
            if (order.paymentCompleted) ...[
              // AppBoxes.kHeight12,
              AppTextButton.secondary(
                text: t.recentOrders.electronicReceipt,
                onTap: () => _showReceiptModal(context),
              ),
              AppBoxes.kHeight24,
            ],

            /// Повторить заказ (status = Отменен)
            if (order.orderStatus == OrderStatus.cancelled &&
                order.orderAgain) ...[
              AppBoxes.kHeight12,
              AppTextButton.primary(
                text: t.recentOrders.repeatOrder,
                onTap: () => _showRepeatOrderModal(context),
              ),
              AppBoxes.kHeight24,
            ],
          ],
        ),
      ),
    );
  }
}
