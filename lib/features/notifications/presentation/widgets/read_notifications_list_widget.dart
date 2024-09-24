import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/features/notifications/domain/model/notification.dart';
import 'package:niagara_app/features/notifications/presentation/widgets/notification_item_widget.dart';

class ReadNotificationsListWidget extends StatelessWidget {
  const ReadNotificationsListWidget({
    super.key,
    required this.date,
    required this.notificationsForDate,
  });

  final DateTime date;
  final List<NotificationItem> notificationsForDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppInsets.kVertical6,
          child: Text(
            DateFormat('d MMMM', 'ru').format(date),
            style: context.textStyle.textTypo.tx2Medium.withColor(
              context.colors.textColors.main,
            ),
          ),
        ),
        ...notificationsForDate.map(
          (notification) => NotificationItemWidget(
            notification: notification,
          ),
        ),
      ],
    );
  }
}
