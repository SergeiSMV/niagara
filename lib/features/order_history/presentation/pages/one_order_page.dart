import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/common/presentation/widgets/app_bar.dart';
import '../../../../core/common/presentation/widgets/snack_bars/app_snack_bar.dart';
import '../../../../core/utils/constants/app_boxes.dart';
import '../../../../core/utils/constants/app_insets.dart';
import '../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../core/utils/extensions/text_style_ext.dart';
import '../../../../core/utils/gen/assets.gen.dart';
import '../../../../core/utils/gen/strings.g.dart';
import '../../domain/models/user_order.dart';
import '../bloc/rate_order_cubit/rate_order_cubit.dart';
import '../widgets/list_products_widget.dart';
import '../widgets/order_data_widget.dart';
import '../widgets/order_item_widgets/bottom_buttons_widget.dart';
import '../widgets/order_status_widget.dart';
import '../widgets/prices_and_bonuses_widget.dart';

/// Экран с одним заказом
@RoutePage()
class OneOrderPage extends StatelessWidget {
  const OneOrderPage({
    required this.order,
    required this.evaluateOrderCubit,
    super.key,
  });

  final UserOrder order;
  final RateOrderCubit evaluateOrderCubit;

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
              child: BottomButtonsWidget(order: order),
            ),
          ],
        ),
      );
}
