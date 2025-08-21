import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/common/domain/models/product.dart';
import '../../../../core/common/presentation/router/app_router.gr.dart';
import '../../../../core/dependencies/di.dart';
import '../../../catalog/presentation/bloc/groups_cubit/groups_cubit.dart';
import '../../../notifications/domain/model/notifications_types.dart';
import '../../../order_history/domain/models/user_order.dart';
import '../../../order_history/presentation/bloc/rate_order_cubit/rate_order_cubit.dart';

/// Обработчик состояния уведомлений
class NotificationStateHandler {
  NotificationStateHandler();

  /// Обработчик нажатия на уведомление с типом [NotificationsTypes.product]
  Future<void> openedProductFromPushHandler(
    BuildContext context,
    Product? product,
  ) async {
    if (product != null) {
      context.navigateTo(ProductRoute(product: product));
    } else {
      context.navigateTo(const NotificationsRoute());
    }
  }

  /// Обработчик нажатия на уведомление
  /// с типом [NotificationsTypes.product_group]
  Future<void> openedProductGroupFromPushHandler(
    BuildContext context,
    String groupId,
  ) async {
    final groupsCubit = getIt<GroupsCubit>();
    final currentGroup = groupsCubit.state.maybeWhen(
      loaded: (groups) {
        final group = groups.firstWhere(
          (group) => group.id == groupId,
        );
        return group;
      },
      orElse: () => null,
    );

    if (currentGroup != null) {
      context.navigateTo(
        CatalogWrapper(
          children: [
            const CatalogRoute(),
            CategoryWrapperRoute(
              group: currentGroup,
              children: const [CategoryRoute()],
            ),
          ],
        ),
      );
    } else {
      context.navigateTo(const NotificationsRoute());
    }
  }

  /// Обработчик нажатия на уведомление с типом [NotificationsTypes.call]
  Future<void> openedCallFromPushHandler(
    BuildContext context,
    String phoneNumber,
  ) async {
    final uri = Uri.parse('tel:$phoneNumber');
    final canLaunch = await canLaunchUrl(uri);

    if (canLaunch) {
      await launchUrl(uri);
    } else {
      context.navigateTo(const NotificationsRoute());
    }
  }

  /// Обработчик нажатия на уведомление с типом [NotificationsTypes.rating]
  Future<void> openedGetRatingFromPushHandler(
    BuildContext context,
    UserOrder? order,
  ) async {
    if (order != null) {
      final evaluateOrderCubit = getIt<RateOrderCubit>();
      context.navigateTo(
        OrdersWrapper(
          children: [
            OneOrderRoute(
              order: order,
              evaluateOrderCubit: evaluateOrderCubit,
              isFromPush: true,
            ),
          ],
        ),
      );
    } else {
      context.navigateTo(const NotificationsRoute());
    }
  }
}
