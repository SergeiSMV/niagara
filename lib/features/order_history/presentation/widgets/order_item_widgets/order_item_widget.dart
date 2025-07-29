import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../core/common/presentation/router/app_router.gr.dart';
import '../../../../../core/dependencies/di.dart';
import '../../../../../core/utils/constants/app_borders.dart';
import '../../../../../core/utils/constants/app_boxes.dart';
import '../../../../../core/utils/constants/app_constants.dart';
import '../../../../../core/utils/constants/app_insets.dart';
import '../../../../../core/utils/constants/app_sizes.dart';
import '../../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../../core/utils/extensions/text_style_ext.dart';
import '../../../../../core/utils/gen/strings.g.dart';
import '../../../domain/models/user_order.dart';
import '../../bloc/rate_order_cubit/rate_order_cubit.dart';
import '../order_status_widget.dart';
import 'bottom_buttons_widget.dart';
import 'bottom_price_widget.dart';

/// Виджет для отображения заказа в списке
class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget({
    required this.order,
    this.inHorizontalList = false,
    this.onSortUpdate,
    super.key,
  });

  final UserOrder order;
  final bool inHorizontalList;

  /// Callback для обновления сортировки
  final VoidCallback? onSortUpdate;

  Future<void> _goToOrderPage(BuildContext context) async {
    final evaluateOrderCubit = BlocProvider.of<RateOrderCubit>(context);

    await context.navigateTo(
      OrdersWrapper(
        children: [
          OneOrderRoute(
            order: order,
            evaluateOrderCubit: evaluateOrderCubit,
          ),
        ],
      ),
    );
  }

  String _returnFormattedDateDelivery() {
    final dayAndMonth =
        DateFormat('EE. dd.MM', 'ru_RU').format(order.dateDelivery);
    final timeBegin = DateFormat('HH:mm').format(order.timeBegin);
    final timeEnd = DateFormat('HH:mm').format(order.timeEnd);
    return '$dayAndMonth, $timeBegin-$timeEnd';
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => getIt<RateOrderCubit>(),
        child: Builder(
          builder: (context) => InkWell(
            onTap: () => _goToOrderPage(context),
            child: Container(
              width: inHorizontalList ? AppSizes.recentOrderItemWidth : null,
              padding: AppInsets.kAll12,
              decoration: BoxDecoration(
                color: context.colors.mainColors.white,
                borderRadius: AppBorders.kCircular12,
                boxShadow: [
                  BoxShadow(
                    color: context.colors.textColors.main
                        .withAlpha((AppSizes.kShadowOpacity * 255).round()),
                    offset: AppConstants.kShadowDiagonal,
                    blurRadius: AppSizes.kGeneral16,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          '${t.recentOrders.orderNumber}${order.orderNumber}',
                          style:
                              context.textStyle.textTypo.tx1SemiBold.copyWith(
                            color: context.colors.buttonColors.accent,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      AppBoxes.kWidth12,
                      OrderStatusWidget(status: order.orderStatus),
                    ],
                  ),
                  if (inHorizontalList) const Spacer() else AppBoxes.kHeight12,
                  Text(
                    t.locations.deliveryAddress,
                    style: context.textStyle.textTypo.tx3Medium.withColor(
                      context.colors.textColors.main,
                    ),
                  ),
                  Text(
                    maxLines: AppConstants.kMaxLines1,
                    overflow: TextOverflow.ellipsis,
                    order.locationName,
                    style: context.textStyle.textTypo.tx3Medium.withColor(
                      context.colors.textColors.secondary,
                    ),
                  ),
                  if (inHorizontalList) const Spacer() else AppBoxes.kHeight8,
                  Text(
                    '${t.recentOrders.deliveryDateIn} ${_returnFormattedDateDelivery()}',
                    style: context.textStyle.textTypo.tx3Medium.withColor(
                      context.colors.textColors.main,
                    ),
                  ),
                  if (inHorizontalList) const Spacer() else AppBoxes.kHeight12,
                  Divider(
                    height: AppSizes.kGeneral2,
                    thickness: AppSizes.kGeneral1,
                    color:
                        context.colors.fieldBordersColors.main.withOpacity(0.3),
                  ),
                  if (inHorizontalList) const Spacer() else AppBoxes.kHeight12,
                  BottomPriceWidget(price: order.totalSum),
                  if (inHorizontalList) const Spacer() else AppBoxes.kHeight12,
                  BottomButtonsWidget(
                    order: order,
                    onSortUpdate: onSortUpdate,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
