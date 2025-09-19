import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../core/common/presentation/router/app_router.gr.dart';
import '../../../../core/common/presentation/widgets/loaders/app_center_loader.dart';
import '../../../../core/utils/constants/app_borders.dart';
import '../../../../core/utils/constants/app_boxes.dart';
import '../../../../core/utils/constants/app_insets.dart';
import '../../../../core/utils/constants/app_sizes.dart';
import '../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../core/utils/extensions/text_style_ext.dart';
import '../../../../core/utils/gen/assets.gen.dart';
import '../../../../core/utils/gen/strings.g.dart';
import '../../domain/models/user_order.dart';
import '../bloc/orders_bloc/orders_bloc.dart';
import 'empty_orders_list_widget.dart';
import 'order_item_widgets/order_item_widget.dart';

/// Список последних заказов на главной странице
class RecentOrdersListWidget extends StatelessWidget {
  const RecentOrdersListWidget({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          final List<UserOrder>? orders = state.maybeWhen(
            loaded: (_, preview) => preview,
            loading: (preview) => preview,
            orElse: () => [],
          );

          /// Лоадер рисуется только если нет `preview`.
          if (orders == null) {
            return const AppCenterLoader();
          } else {
            final firstFourOrders =
                orders.length <= 4 ? orders : orders.sublist(0, 4);

            return firstFourOrders.isEmpty
                ? const EmptyOrdersListWidget()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBoxes.kHeight32,
                      Padding(
                        padding: AppInsets.kHorizontal16,
                        child: Text(
                          t.recentOrders.recentOrders,
                          style: context.textStyle.headingTypo.h3
                              .withColor(context.colors.textColors.main),
                        ),
                      ),
                      SizedBox(
                        height: AppSizes.kListItemsHeight,
                        child: _OrdersListWidget(
                          firstFourOrders: firstFourOrders,
                        ),
                      ),
                    ],
                  );
          }
        },
      );
}

/// Сам виджет списка заказов
class _OrdersListWidget extends StatefulWidget {
  const _OrdersListWidget({
    required this.firstFourOrders,
  });

  /// Первые четыре заказа.
  final List<UserOrder> firstFourOrders;

  @override
  State<_OrdersListWidget> createState() => _OrdersListWidgetState();
}

class _OrdersListWidgetState extends State<_OrdersListWidget> {
  /// Контроллер для обновления списка.
  final RefreshController _refreshController = RefreshController();

  /// Строит элемент списка заказов.
  Widget _buildOrderItem(int index) => Padding(
        padding: AppInsets.kRight12 +
            AppInsets.kVertical20 +
            (index == 0 ? AppInsets.kLeft16 : EdgeInsets.zero),
        child: OrderItemWidget(
          inHorizontalList: true,
          order: widget.firstFourOrders[index],
        ),
      );

  /// Строит индикатор обновления.
  Widget _refreshIndicatorBuilder(context, state) => switch (state) {
        RefreshStatus.refreshing => const AppCenterLoader(
            dense: true,
            size: AppSizes.kLoaderSmall,
          ),
        _ => const SizedBox.shrink(),
      };

  Future<void> _onRefresh() async {
    context.read<OrdersBloc>().add(const OrdersEvent.loadPreview());
  }

  /// Слушает состояние загрузки заказов.
  void _ordersLoadingStateListener(BuildContext context, OrdersState state) {
    state.maybeWhen(
      loaded: (_, preview) => _refreshController.refreshCompleted(),
      error: _refreshController.refreshFailed,
      orElse: () {},
    );
  }

  @override
  Widget build(BuildContext context) => BlocListener<OrdersBloc, OrdersState>(
        listener: _ordersLoadingStateListener,
        child: Padding(
          padding: EdgeInsets.zero,
          child: SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            header: CustomHeader(builder: _refreshIndicatorBuilder),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...List.generate(
                  widget.firstFourOrders.length,
                  _buildOrderItem,
                ),
                const _AllOrdersButtonWidget(),
              ],
            ),
          ),
        ),
      );
}

class _AllOrdersButtonWidget extends StatelessWidget {
  const _AllOrdersButtonWidget();

  Future<void> _goToOrders(BuildContext context) async {
    context.navigateTo(const OrdersWrapper(children: [OrdersRoute()]));

    context
        .read<OrdersBloc>()
        .add(const OrdersEvent.loading(isForceUpdate: true));
  }

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () async => _goToOrders(context),
        child: Padding(
          padding: AppInsets.kVertical20 + AppInsets.kRight16,
          child: Container(
            padding: AppInsets.kHorizontal8,
            decoration: BoxDecoration(
              borderRadius: AppBorders.kCircular12,
              color: context.colors.mainColors.accent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.icons.boxOrder.svg(
                  // ignore: deprecated_member_use_from_same_package
                  color: context.colors.mainColors.white,
                ),
                AppBoxes.kHeight8,
                Text(
                  t.recentOrders.allOrders,
                  textAlign: TextAlign.center,
                  style: context.textStyle.buttonTypo.btn3bold
                      .withColor(context.colors.mainColors.white),
                ),
              ],
            ),
          ),
        ),
      );
}
