import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/common/presentation/router/app_router.gr.dart';
import '../../../../core/dependencies/di.dart';
import '../../../../core/utils/enums/orders_types.dart';
import '../../../catalog/presentation/bloc/groups_cubit/groups_cubit.dart';
import '../../../notifications/domain/model/notifications_types.dart';
import '../../../order_history/domain/models/user_order.dart';
import '../../../order_history/presentation/bloc/orders_bloc/orders_bloc.dart';
import '../../../order_history/presentation/bloc/rate_order_cubit/rate_order_cubit.dart';
import '../../domain/product_by_id_usecase.dart';

/// Обработчик состояния уведомлений
/// TODO: Весь этот класс - один большой костыль, нужно переписать
/// после добавления прямых методов для получения нужных данных
class NotificationStateHandler {
  NotificationStateHandler();

  /// Обработчик нажатия на уведомление с типом [NotificationsTypes.product]
  Future<void> openedProductFromPushHandler(
      BuildContext context, String productId, String productName) async {
    final productByIdUsecase = getIt<ProductByIdUsecase>();
    final product = await productByIdUsecase(productId, productName);

    if (product != null) {
      context.navigateTo(ProductRoute(product: product));
    } else {
      context.navigateTo(const NotificationsRoute());
    }
  }

  /// Обработчик нажатия на уведомление с типом [NotificationsTypes.product_group]
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

  /// Обработчик нажатия на уведомление с типом [NotificationsTypes.get_rating]
  Future<void> openedGetRatingFromPushHandler(
    BuildContext context,
    String orderID,
  ) async {
    final order = await _findOrderById(orderID);

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

  /// Поиск заказа по ID с пагинацией
  Future<UserOrder?> _findOrderById(String orderId) async =>
      _findOrderByIdRecursive(orderId, 1);

  /// Рекурсивный поиск заказа по страницам
  Future<UserOrder?> _findOrderByIdRecursive(String orderId, int page) async {
    final ordersBloc = getIt<OrdersBloc>();

    // Если это первая страница, меняем сортировку
    if (page == 1) {
      ordersBloc.add(const OrdersEvent.setSort(sort: OrdersTypes.finish));
    }

    // Загружаем заказы для текущей страницы
    ordersBloc.add(OrdersEvent.loading(isForceUpdate: page == 1));

    // Ждем загрузки данных
    await Future.delayed(const Duration(milliseconds: 2000));

    // Проверяем загруженные заказы
    final order = ordersBloc.state.maybeWhen(
      loaded: (orders, preview) {
        final foundOrder =
            orders.firstWhereOrNull((order) => order.id == orderId);
        return foundOrder;
      },
      orElse: () => null,
    );

    if (order != null) {
      return order;
    }

    // Если заказ не найден и есть еще страницы, переходим к следующей
    if (ordersBloc.hasMore) {
      return _findOrderByIdRecursive(orderId, page + 1);
    }
    return null;
  }
}
