import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/gen/assets.gen.dart';
import '../../../support/presentation/support_cubit.dart';
import 'action_button.dart';

/// Кнопка-иконка для открытия страницы с чатом службы поддержки.
class SupportButton extends StatelessWidget {
  const SupportButton({Key? key}) : super(key: key);

  /// Открывает страницу с чатом службы поддержки.
  Future<void> _openSupportChat(BuildContext context) =>
      context.read<SupportCubit>().openChat();

  @override
  Widget build(BuildContext context) => AppBarActionButton(
        icon: Assets.icons.support,
        onTap: () async => _openSupportChat(context),
      );
}
