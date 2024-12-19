import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class NoNotificationsWidget extends StatelessWidget {
  const NoNotificationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 7),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: AppInsets.kHorizontal72,
              child: Assets.images.yourNotifications.image(),
            ),
            AppBoxes.kHeight16,
            Text(
              t.notifications.yourNotifications,
              textAlign: TextAlign.center,
              style: context.textStyle.headingTypo.h3.withColor(
                context.colors.textColors.main,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
