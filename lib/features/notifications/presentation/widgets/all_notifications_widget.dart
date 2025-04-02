import 'package:flutter/material.dart';
import '../../../../core/utils/constants/app_insets.dart';
import '../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../core/utils/extensions/text_style_ext.dart';
import '../../../../core/utils/gen/strings.g.dart';
import '../../domain/model/notification.dart';
import 'notification_item_widget.dart';
import 'read_notifications_list_widget.dart';

class AllNotificationsWidget extends StatelessWidget {
  const AllNotificationsWidget({
    required this.unreadNotifications,
    required this.groupedNotifications,
    super.key,
  });

  final List<NotificationItem> unreadNotifications;
  final List<GroupedNotifications> groupedNotifications;

  @override
  Widget build(BuildContext context) => Padding(
        padding: AppInsets.kHorizontal16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (unreadNotifications.isNotEmpty)
              Text(
                t.notifications.unread,
                style: context.textStyle.textTypo.tx2Medium.withColor(
                  context.colors.textColors.main,
                ),
              ),
            ...unreadNotifications.map(
              (e) => NotificationItemWidget(notification: e),
            ),
            ...groupedNotifications.map(
              (e) => ReadNotificationsListWidget(
                date: e.date,
                notificationsForDate: e.groupedNotifications,
              ),
            ),
          ],
        ),
      );
}
