import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/auth/presentation/bloc/auth_bloc.dart';

/// Кнопка "Авторизоваться позже".
class AuthLaterButton extends StatelessWidget {
  /// Создает экземпляр [AuthLaterButton].
  const AuthLaterButton({super.key});

  @override
  Widget build(BuildContext context) {
    void onTapAuthLater() =>
        context.read<AuthBloc>().add(const AuthEvent.authLater());

    return AppTextButton.invisible(
      text: t.auth.authLater,
      onTap: onTapAuthLater,
    );
  }
}
