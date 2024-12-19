import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/notifications/presentation/bloc/permission_cubit.dart/notification_permission_cubit.dart';

class NotificationWarningWidget extends StatelessWidget {
  const NotificationWarningWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<NotificationPermissionCubit>();

    if (cubit.state) {
      return const SizedBox();
    }

    return GestureDetector(
      onTap: () => cubit.openSettings(),
      child: Container(
        margin: AppInsets.kVertical12 + AppInsets.kHorizontal16,
        padding: AppInsets.kAll12,
        decoration: BoxDecoration(
          color: context.colors.infoColors.bgBlue,
          borderRadius: AppBorders.kCircular12,
        ),
        child: Row(
          children: [
            Assets.icons.infoLightBlueFill.svg(),
            AppBoxes.kWidth16,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    t.notifications.turnNotifications,
                    style: context.textStyle.textTypo.tx2SemiBold.withColor(
                      context.colors.textColors.main,
                    ),
                  ),
                  AppBoxes.kHeight4,
                  Text(
                    t.notifications.stayUpToDateWithLatest,
                    style: context.textStyle.descriptionTypo.des3.withColor(
                      context.colors.textColors.main,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
