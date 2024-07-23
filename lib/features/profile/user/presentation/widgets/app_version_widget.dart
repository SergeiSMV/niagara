import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class AppVersionWidget extends StatelessWidget {
  const AppVersionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Получать версию приоложения
    return Padding(
      padding: AppInsets.kLeft16 + AppInsets.kBottom44,
      child: Text(
        t.profile.appInfo.appVersion(version: '6.0.3 (712)'),
        style: context.textStyle.textTypo.tx3Medium.withColor(
          context.colors.textColors.secondary,
        ),
      ),
    );
  }
}
