import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/notifications/domain/model/notification.dart';
import 'package:niagara_app/features/notifications/presentation/widgets/notification_item_widget.dart';
import 'package:niagara_app/features/notifications/presentation/widgets/read_notifications_list_widget.dart';

class AllNotificationsWidget extends StatelessWidget {
  const AllNotificationsWidget({
    super.key,
    required this.unreadNotifications,
    required this.groupedNotifications,
  });

  final List<NotificationItem> unreadNotifications;
  final List<GroupedNotifications> groupedNotifications;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
}
