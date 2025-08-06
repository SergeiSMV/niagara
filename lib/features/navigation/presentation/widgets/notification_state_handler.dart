import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/common/presentation/router/app_router.gr.dart';
import '../../../../core/dependencies/di.dart';
import '../../../catalog/presentation/bloc/groups_cubit/groups_cubit.dart';
import '../../../notifications/domain/model/notifications_types.dart';
import '../../domain/product_by_id_usecase.dart';

/// Обработчик состояния уведомлений
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
}
