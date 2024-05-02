import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/home/presentation/widgets/action_button.dart';

class NotificationsButton extends StatelessWidget {
  const NotificationsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBarActionButton(
      icon: Assets.icons.notifications,
      // TODO(Oleg): Реализовать переход на экран уведомлений
      onTap: () => debugPrint('Notifications'),
    );
  }
}
