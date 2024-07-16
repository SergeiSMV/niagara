import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/home/presentation/widgets/action_button.dart';
import 'package:niagara_app/features/notifications/presentation/bloc/notifications_bloc/notifications_bloc.dart';

class NotificationsButton extends StatelessWidget {
  const NotificationsButton({super.key});

  void _goToNotifications(BuildContext context) =>
      context.navigateTo(const NotificationsRoute());

  SvgGenImage _definitionIcon(NotificationsState state) => state.maybeWhen(
        loaded: (_, __, isNewNotifications) => isNewNotifications
            ? Assets.icons.notificationsUnread
            : Assets.icons.notifications,
        orElse: () => Assets.icons.notifications,
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsBloc, NotificationsState>(
      builder: (context, state) {
        return AppBarActionButton(
          icon: _definitionIcon(state),
          onTap: () => _goToNotifications(context),
        );
      },
    );
  }
}
