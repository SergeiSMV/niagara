import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/features/notifications/domain/model/notifications_types.dart';
import 'package:niagara_app/features/notifications/presentation/bloc/notifications_bloc/notifications_bloc.dart';
import 'package:niagara_app/features/notifications/presentation/widgets/push_type_item_widget.dart';

class NotificationTypeButtons extends StatelessWidget {
  const NotificationTypeButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<NotificationsBloc>();

    return BlocBuilder<NotificationsBloc, NotificationsState>(
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: AppInsets.kAll12,
            child: Row(
              children: [
                ...List.generate(NotificationsTypes.values.length, (index) {
                  return PushTypeItemWidget(
                    name: NotificationsTypes.values[index],
                    isSelected: NotificationsTypes.values[index] == bloc.type,
                  );
                }),
                AppBoxes.kWidth12,
              ],
            ),
          ),
        );
      },
    );
  }
}
