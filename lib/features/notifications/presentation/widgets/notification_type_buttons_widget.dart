import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/constants/app_boxes.dart';
import '../../../../core/utils/constants/app_insets.dart';
import '../../domain/model/notifications_types.dart';
import '../bloc/notifications_bloc/notifications_bloc.dart';
import 'push_type_item_widget.dart';

/// Виджет для отображения кнопок типов уведомлений
class NotificationTypeButtons extends StatelessWidget {
  const NotificationTypeButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<NotificationsBloc>();

    return BlocBuilder<NotificationsBloc, NotificationsState>(
      builder: (context, state) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: AppInsets.kAll12,
          child: Row(
            children: [
              ...NotificationsTypes.values
                  .where(
                    (type) =>
                        type != NotificationsTypes.product_group &&
                        type != NotificationsTypes.product,
                  )
                  .map(
                    (type) => PushTypeItemWidget(
                      name: type,
                      isSelected: type == bloc.type,
                    ),
                  ),
              AppBoxes.kWidth12,
            ],
          ),
        ),
      ),
    );
  }
}
