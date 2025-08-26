import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../core/common/presentation/widgets/app_network_image_widget.dart';
import '../../../../core/dependencies/di.dart';
import '../../../../core/utils/constants/app_borders.dart';
import '../../../../core/utils/constants/app_boxes.dart';
import '../../../../core/utils/constants/app_constants.dart';
import '../../../../core/utils/constants/app_insets.dart';
import '../../../../core/utils/constants/app_sizes.dart';
import '../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../core/utils/extensions/text_style_ext.dart';
import '../../domain/model/notification.dart';
import '../../domain/model/notifications_types.dart';
import '../bloc/read_notification_cubit/read_notification_cubit.dart';
import 'notification_route_handler.dart';

class NotificationItemWidget extends StatelessWidget {
  const NotificationItemWidget({
    required this.notification,
    super.key,
  });

  /// Уведомление.
  final NotificationItem notification;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => getIt<ReadNotificationCubit>(),
        child: _NotificationItemContent(notification: notification),
      );
}

/// Виджет для отображения уведомления.
class _NotificationItemContent extends StatelessWidget {
  const _NotificationItemContent({
    required this.notification,
  });

  /// Уведомление.
  final NotificationItem notification;

  /// Метод для перехода в страницу уведомления
  Future<void> _goToPage(BuildContext context) async {
    NotificationRouteHandler().notificationTapHandler(context, notification);
  }

  /// Метод для отмечания уведомления как прочитанного при скролле
  Future<void> _readIt(BuildContext context) async {
    if (notification.isNew && notification.type == NotificationsTypes.system) {
      await context
          .read<ReadNotificationCubit?>()
          ?.readNotification(notification.id);
    }
  }

  @override
  Widget build(BuildContext context) => VisibilityDetector(
        key: Key(notification.id),
        onVisibilityChanged: (_) => _readIt(context),
        child: Stack(
          children: [
            Container(
              margin: AppInsets.kVertical6,
              decoration: BoxDecoration(
                borderRadius: AppBorders.kCircular12,
                color: context.colors.mainColors.white,
                boxShadow: [
                  BoxShadow(
                    color: context.colors.otherColors.itemShadow
                        .withOpacity(AppSizes.kShadowOpacity0_8),
                    offset: AppConstants.kShadowBottom,
                    blurRadius: AppSizes.kGeneral8,
                  ),
                ],
              ),
              child: InkWell(
                onTap: () async => _goToPage(context),
                borderRadius: AppBorders.kCircular12,
                child: Padding(
                  padding: AppInsets.kAll12,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: AppBorders.kCircular4,
                        child: AppNetworkImageWidget(
                          url: notification.icon,
                          height: AppSizes.notificationIconHeight,
                          width: AppSizes.notificationIconWidth,
                        ),
                      ),
                      AppBoxes.kWidth8,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notification.title,
                              style: context.textStyle.textTypo.tx2SemiBold
                                  .withColor(
                                context.colors.textColors.main,
                              ),
                            ),
                            Text(
                              notification.description,
                              style: context.textStyle.textTypo.tx3Medium
                                  .withColor(
                                context.colors.textColors.secondary,
                              ),
                            ),
                            if (notification.image.isNotEmpty)
                              AppBoxes.kHeight12,
                            if (notification.image.isNotEmpty)
                              ClipRRect(
                                borderRadius: AppBorders.kCircular12,
                                child: AppNetworkImageWidget(
                                  url: notification.image,
                                ),
                              ),
                            AppBoxes.kHeight12,
                            Text(
                              DateFormat('HH:mm').format(notification.date),
                              style: context.textStyle.descriptionTypo.des3
                                  .withColor(
                                context.colors.textColors.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (notification.isNew)
              Positioned(
                top: AppSizes.notificationIndicatorTopPadding,
                right: AppSizes.notificationIndicatorRightPadding,
                child: Container(
                  height: AppSizes.notificationIndicatorHeight,
                  width: AppSizes.notificationIndicatorWidth,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colors.infoColors.green,
                  ),
                ),
              ),
          ],
        ),
      );
}
