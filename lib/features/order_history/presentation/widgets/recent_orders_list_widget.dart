import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/enums/order_status.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/order_history/domain/models/recent_order.dart';
import 'package:niagara_app/features/order_history/presentation/bloc/orders_bloc/orders_bloc.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/empty_orders_list_widget.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/recent_order_item_widget.dart';

class RecentOrdersListWidget extends StatelessWidget {
  const RecentOrdersListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const list = [
      RecentOrder(
        orderNumber: 24345,
        deliveryAddress: 'ул. Ростовское ш., дом 22/б',
        deliveryDate: 'Пн. 16.02, 12:00-16:00',
        price: 599,
        status: OrderStatus.cancelled,
      ),
      RecentOrder(
        orderNumber: 24345,
        deliveryAddress: 'ул. Ростовское ш., дом 22/б',
        deliveryDate: 'Пн. 16.02, 12:00-16:00',
        price: 599,
        status: OrderStatus.goingTo,
      ),
      RecentOrder(
        orderNumber: 24345,
        deliveryAddress: 'ул. Ростовское ш., дом 22/б',
        deliveryDate: 'Пн. 16.02, 12:00-16:00',
        price: 599,
        status: OrderStatus.onWay,
      ),
      RecentOrder(
        orderNumber: 24345,
        deliveryAddress: 'ул. Ростовское ш., дом 22/б',
        deliveryDate: 'Пн. 16.02, 12:00-16:00',
        price: 599,
        status: OrderStatus.received,
      ),
    ];

    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) => state.maybeWhen(
        loaded: (orders) {
          final firstFourOrders =
              orders.length <= 4 ? orders : orders.sublist(0, 4);

          return orders.isEmpty
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
                      child: SingleChildScrollView(
                        padding: AppInsets.kHorizontal16,
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: AppInsets.kVertical20,
                          child: Row(
                            children: [
                              ...List.generate(
                                firstFourOrders.length,
                                (index) => Padding(
                                  padding: AppInsets.kRight12,
                                  child: RecentOrderItemWidget(
                                    inHorizontalList: true,
                                    order: firstFourOrders[index],
                                  ),
                                ),
                              ),
                              const _AllOrdersButtonWidget(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        },
        orElse: () => const SizedBox.shrink(),
      ),
    );
  }
}

class _AllOrdersButtonWidget extends StatelessWidget {
  const _AllOrdersButtonWidget();

  void _goToOrders(BuildContext context) => context.navigateTo(
        const ProfileWrapper(
          children: [
            ProfileRoute(),
            OrdersRoute(),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _goToOrders(context),
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
    );
  }
}
