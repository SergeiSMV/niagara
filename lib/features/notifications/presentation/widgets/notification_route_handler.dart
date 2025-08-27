import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/common/presentation/router/app_router.gr.dart';
import '../../../../core/core.dart';
import '../../../../core/dependencies/di.dart';
import '../../../catalog/domain/use_cases/get_product_by_id_use_case.dart';
import '../../../catalog/presentation/bloc/groups_cubit/groups_cubit.dart';
import '../../../order_history/domain/use_cases/get_order_by_id_use_case.dart';
import '../../../order_history/presentation/bloc/rate_order_cubit/rate_order_cubit.dart';
import '../../domain/model/notification.dart';
import '../../domain/model/notifications_types.dart';
import '../bloc/read_notification_cubit/read_notification_cubit.dart';

/// Обработчик нажатия на уведомление
class NotificationRouteHandler {
  NotificationRouteHandler();

  /// Метод для обработки нажатия на уведомление
  Future<void> notificationTapHandler(
    BuildContext context,
    NotificationItem notification,
  ) async {
    switch (notification.type) {
      case NotificationsTypes.orders:
        _readNotification(context, notification);
      case NotificationsTypes.offers:
        _readNotification(context, notification);
      case NotificationsTypes.system:
        _readNotification(context, notification);
      case NotificationsTypes.product_group:
        await _productGroup(context, notification);
      case NotificationsTypes.rating:
        await _rating(context, notification);
      case NotificationsTypes.call:
        await _call(context, notification);
      case NotificationsTypes.product:
        await _product(context, notification);
      default:
        _readNotification(context, notification);
    }
  }

  /// Метод для отмечания уведомления как прочитанного
  static Future<void> _readNotification(
    BuildContext context,
    NotificationItem notification,
  ) async {
    context.read<ReadNotificationCubit?>()?.readNotification(notification.id);
  }

  /// Метод для перехода в страницу товара
  static Future<void> _product(
    BuildContext context,
    NotificationItem notification,
  ) async {
    final _getProductByIdUseCase = getIt<GetProductByIdUseCase>();
    final product = await _getProductByIdUseCase(notification.link).fold(
      (_) => null,
      (product) => product,
    );

    if (product != null) {
      context.navigateTo(ProductRoute(product: product));
      _readNotification(context, notification);
    }
  }

  /// Метод для перехода в страницу группы товаров
  static Future<void> _productGroup(
    BuildContext context,
    NotificationItem notification,
  ) async {
    final groupsCubit = getIt<GroupsCubit>();
    final currentGroup = groupsCubit.state.maybeWhen(
      loaded: (groups) {
        final group = groups.firstWhere(
          (group) => group.id == notification.link,
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
    }
    _readNotification(context, notification);
  }

  /// Метод для вызова номера телефона
  static Future<void> _call(
    BuildContext context,
    NotificationItem notification,
  ) async {
    final uri = Uri.parse('tel:${notification.link}');
    final canLaunch = await canLaunchUrl(uri);

    if (canLaunch) {
      await launchUrl(uri);
    }
    _readNotification(context, notification);
  }

  /// Метод для перехода в страницу оценки заказа
  static Future<void> _rating(
    BuildContext context,
    NotificationItem notification,
  ) async {
    final _getOrderByIdUseCase = getIt<GetOrderByIdUseCase>();
    final order = await _getOrderByIdUseCase(notification.link).fold(
      (_) => null,
      (order) => order,
    );

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
    }
    _readNotification(context, notification);
  }
}
