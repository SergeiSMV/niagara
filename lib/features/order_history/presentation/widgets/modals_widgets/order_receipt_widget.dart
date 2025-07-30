import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../../../core/common/presentation/widgets/app_bar.dart';
import '../../../../../core/common/presentation/widgets/errors/error_refresh_widget.dart';
import '../../../../../core/common/presentation/widgets/loaders/app_center_loader.dart';
import '../../../../../core/dependencies/di.dart';
import '../../../../../core/utils/constants/app_insets.dart';
import '../../../../../core/utils/gen/strings.g.dart';
import '../../../domain/models/user_order.dart';
import '../../bloc/order_receipt_cubit.dart/receipt_cubit.dart';

/// Виджет, отображающий чек заказа.
class OrderReceiptWidget extends StatelessWidget {
  const OrderReceiptWidget({required this.order, super.key});

  /// Заказ, для которого отображается чек.
  final UserOrder order;

  /// Загрузка чека заказа.
  void _loadReceipt(BuildContext context, String orderId) =>
      context.read<OrderReceiptCubit>().getOrderReceipt(orderId);

  @override
  Widget build(BuildContext context) => BlocProvider<OrderReceiptCubit>(
        create: (_) => getIt<OrderReceiptCubit>()..getOrderReceipt(order.id),
        child: CustomScrollView(
          slivers: [
            SliverAppBarWidget(
              title: '${t.recentOrders.orderNumber}${order.orderNumber}',
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: AppInsets.kAll16,
                child: BlocBuilder<OrderReceiptCubit, OrderReceiptState>(
                  builder: (_, state) => state.maybeWhen(
                    loaded: (receipt) => HtmlWidget(receipt.html),
                    error: () => ErrorRefreshWidget(
                      onRefresh: () => _loadReceipt(context, order.id),
                    ),
                    orElse: AppCenterLoader.new,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
