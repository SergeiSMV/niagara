import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../core/common/presentation/router/app_router.gr.dart';
import '../../../../../core/utils/constants/app_borders.dart';
import '../../../../../core/utils/constants/app_boxes.dart';
import '../../../../../core/utils/constants/app_insets.dart';
import '../../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../../core/utils/gen/assets.gen.dart';
import '../../../../../core/utils/gen/strings.g.dart';
import 'profile_action_tile.dart';
import 'profile_actions_widget.dart';

class AppInfoWidget extends StatelessWidget {
  const AppInfoWidget({super.key});

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.mainColors.white,
          borderRadius: AppBorders.kCircular18,
        ),
        child: Padding(
          padding: AppInsets.kHorizontal16 + AppInsets.kVertical12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBoxes.kHeight4,
              Text(
                t.profile.appInfo.appInfoHeader,
                style: context.textStyle.textTypo.tx1SemiBold,
              ),
              AppBoxes.kHeight8,
              ProfileActionsWidget(
                children: [
                  ProfileActionTile(
                    leadingIcon: Assets.icons.info,
                    title: t.profile.appInfo.aboutApp,
                    redirectRoute: const AboutAppRoute(),
                  ),
                  ProfileActionTile(
                    leadingIcon: Assets.icons.support,
                    title: t.profile.appInfo.support,
                    onTap: () => context.navigateTo(const SupportChatRoute()),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
