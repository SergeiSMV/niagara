import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/errors/error_refresh_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/order_history/domain/models/user_order.dart';
import 'package:niagara_app/features/order_history/presentation/bloc/order_receipt_cubit.dart/receipt_cubit.dart';

/// Виджет, отображающий чек заказа.
class OrderReceiptWidget extends StatelessWidget {
  const OrderReceiptWidget({super.key, required this.order});

  /// Заказ, для которого отображается чек.
  final UserOrder order;

  /// Загрузка чека заказа.
  void _loadReceipt(BuildContext context, String orderId) =>
      context.read<OrderReceiptCubit>().getOrderReceipt(orderId);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderReceiptCubit>(
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
}
