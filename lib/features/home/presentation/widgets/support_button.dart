import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/common/presentation/router/app_router.gr.dart';
import '../../../../core/utils/gen/assets.gen.dart';
import 'action_button.dart';

/// Кнопка-иконка для открытия страницы с чатом службы поддержки.
class SupportButton extends StatelessWidget {
  const SupportButton({Key? key}) : super(key: key);

  /// Открывает страницу с чатом службы поддержки.
  Future<void> _openSupportChat(BuildContext context) =>
      context.navigateTo(const SupportChatRoute());

  @override
  Widget build(BuildContext context) => AppBarActionButton(
        icon: Assets.icons.support,
        onTap: () async => _openSupportChat(context),
      );
}
