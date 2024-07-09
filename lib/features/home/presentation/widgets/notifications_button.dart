import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/home/presentation/widgets/action_button.dart';

class NotificationsButton extends StatelessWidget {
  const NotificationsButton({super.key});

  void _goToNotifications(BuildContext context) =>
      context.navigateTo(const NotificationsRoute());

  @override
  Widget build(BuildContext context) {
    return AppBarActionButton(
      icon: Assets.icons.notifications,
      onTap: () => _goToNotifications(context),
    );
  }
}
