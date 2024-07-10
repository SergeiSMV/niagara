import 'package:auto_route/auto_route.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/features/notifications/domain/model/notification.dart';
import 'package:niagara_app/features/notifications/domain/model/notifications_types.dart';
import 'package:niagara_app/features/notifications/presentation/bloc/read_notification_cubit/read_notification_cubit.dart';
import 'package:visibility_detector/visibility_detector.dart';

class NotificationItemWidget extends StatelessWidget {
  const NotificationItemWidget({
    super.key,
    required this.notification,
  });

  final NotificationItem notification;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ReadNotificationCubit>(),
      child: _NotificationItemContent(notification: notification),
    );
  }
}

class _NotificationItemContent extends StatelessWidget {
  const _NotificationItemContent({
    required this.notification,
  });

  final NotificationItem notification;

  void _goToPage(BuildContext context) {
    context.read<ReadNotificationCubit>().readNotification(notification.id);
    if (notification.type == NotificationsTypes.offers) {
      context.navigateTo(OneNotificationRoute(notification: notification));
    }
  }

  void _readIt(BuildContext context) {
    if (notification.isNew && notification.type == NotificationsTypes.system) {
      context.read<ReadNotificationCubit>().readNotification(notification.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
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
              onTap: () => _goToPage(context),
              borderRadius: AppBorders.kCircular12,
              child: Padding(
                padding: AppInsets.kAll12,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: AppBorders.kCircular4,
                      child: ExtendedImage.network(
                        notification.icon,
                        height: AppSizes.notificationIconHeight,
                        width: AppSizes.notificationIconWidth,
                        fit: BoxFit.cover,
                        loadStateChanged: (state) =>
                            state.extendedImageLoadState == LoadState.loading
                                ? const AppCenterLoader()
                                : null,
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
                            style:
                                context.textStyle.textTypo.tx3Medium.withColor(
                              context.colors.textColors.secondary,
                            ),
                          ),
                          if (notification.image.isNotEmpty) AppBoxes.kHeight12,
                          if (notification.image.isNotEmpty)
                            ClipRRect(
                              borderRadius: AppBorders.kCircular12,
                              child: ExtendedImage.network(
                                notification.image,
                                fit: BoxFit.cover,
                                loadStateChanged: (state) =>
                                    state.extendedImageLoadState ==
                                            LoadState.loading
                                        ? const AppCenterLoader()
                                        : null,
                              ),
                            ),
                          AppBoxes.kHeight12,
                          Text(
                            DateFormat('hh:mm').format(notification.date),
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
}
