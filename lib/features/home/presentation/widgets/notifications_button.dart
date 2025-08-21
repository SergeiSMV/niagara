import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/presentation/router/app_router.gr.dart';
import '../../../../core/utils/gen/assets.gen.dart';
import '../../../notifications/presentation/bloc/notifications_bloc/notifications_bloc.dart';
import 'action_button.dart';

/// Виджет для отображения кнопки уведомлений
class NotificationsButton extends StatelessWidget {
  const NotificationsButton({super.key});

  /// Переход на страницу уведомлений
  void _goToNotifications(BuildContext context) =>
      context.navigateTo(const NotificationsRoute());

  /// Определение иконки уведомлений в зависимости от состояния уведомлений
  SvgGenImage _definitionIcon(NotificationsState state) => state.maybeWhen(
        loaded: (_, __, isNewNotifications) => isNewNotifications
            ? Assets.icons.notificationsUnread
            : Assets.icons.notifications,
        orElse: () => Assets.icons.notifications,
      );

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (context, state) => AppBarActionButton(
          icon: _definitionIcon(state),
          onTap: () => _goToNotifications(context),
        ),
      );
}
