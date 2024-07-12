import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/order_history/domain/models/recent_order.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/order_data_widget.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/order_status_widget.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/prices_and_bonuses_widget.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/product_item_widget.dart';

@RoutePage()
class OneOrderPage extends StatelessWidget {
  const OneOrderPage({
    super.key,
    required this.order,
  });

  final RecentOrder order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBarWidget(
            title: '${t.recentOrders.orderNumber}${order.orderNumber}',
            actions: [
              InkWell(
                onTap: () {},
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
                    'Создан Пн. 07.02, 14:00 ',
                    style: context.textStyle.textTypo.tx2Medium.withColor(
                      context.colors.textColors.main,
                    ),
                  ),
                  OrderStatusWidget(
                    status: order.status,
                    padding: AppInsets.kHorizontal14,
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: AppBoxes.kHeight28),
          const SliverToBoxAdapter(
            child: Padding(
              padding: AppInsets.kHorizontal16,
              child: OrderDataWidget(),
            ),
          ),
          const SliverToBoxAdapter(child: AppBoxes.kHeight32),
          const SliverToBoxAdapter(
            child: Padding(
              padding: AppInsets.kHorizontal16,
              child: PricesAndBonusesWidget(),
            ),
          ),
          const SliverToBoxAdapter(child: AppBoxes.kHeight16),
          SliverPadding(
            padding: AppInsets.kHorizontal16,
            sliver: SliverList.separated(
              itemCount: 4,
              itemBuilder: (context, index) => const ProductItemWidget(),
              separatorBuilder: (_, __) => AppBoxes.kHeight8,
            ),
          ),
        ],
      ),
    );
  }
}
