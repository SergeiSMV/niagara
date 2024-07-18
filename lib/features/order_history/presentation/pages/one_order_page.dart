import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/enums/order_status.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/order_history/domain/models/user_order.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/list_products_widget.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/order_data_widget.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/order_status_widget.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/prices_and_bonuses_widget.dart';

@RoutePage()
class OneOrderPage extends StatelessWidget {
  const OneOrderPage({
    super.key,
    required this.order,
  });

  final UserOrder order;

  Future<void> _copyOrderNumber() async => await Clipboard.setData(
        ClipboardData(text: order.orderNumber),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBarWidget(
            title: '${t.recentOrders.orderNumber}${order.orderNumber}',
            actions: [
              InkWell(
                onTap: () => _copyOrderNumber(),
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
          _BottomButtonsWidget(status: order.orderStatus),
        ],
      ),
    );
  }
}

class _BottomButtonsWidget extends StatelessWidget {
  const _BottomButtonsWidget({
    required this.status,
  });

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: AppInsets.kHorizontal16,
        child: Column(
          children: [
            AppBoxes.kHeight24,

            /// Отменить заказ (собирается)
            if (status == OrderStatus.goingTo) ...[
              AppTextButton.secondary(
                text: t.recentOrders.cancelOrder,
                onTap: () {},
              ),
            ],

            /// Связаться с водителем (в пути)
            if (status == OrderStatus.onWay) ...[
              AppTextButton.primary(
                text: t.recentOrders.contactDriver,
                onTap: () {},
              ),
            ],

            /// Повторить заказ (Получен)
            if (status == OrderStatus.received) ...[
              AppTextButton.primary(
                text: t.recentOrders.repeatOrder,
                onTap: () {},
              ),
              AppBoxes.kHeight12,

              /// Электронный чек (Получен)
              AppTextButton.secondary(
                text: t.recentOrders.electronicReceipt,
                onTap: () {},
              ),
              AppBoxes.kHeight12,

              /// Оценить заказ (Получен)
              AppTextButton.secondary(
                text: t.recentOrders.evaluateOrder,
                onTap: () {},
              ),
            ],

            /// Повторить заказ (Отменен)
            if (status == OrderStatus.cancelled) ...[
              AppTextButton.primary(
                text: t.recentOrders.repeatOrder,
                onTap: () {},
              ),
            ],
            AppBoxes.kHeight24,
          ],
        ),
      ),
    );
  }
}
