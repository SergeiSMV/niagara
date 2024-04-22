import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';

/// Кнопка "Авторизоваться позже".
class AuthLaterButton extends StatelessWidget {
  const AuthLaterButton({super.key});

  void onTapAuthLater(BuildContext context) => context
    ..read<AuthBloc>().add(const AuthEvent.authLater())
    ..replaceRoute(const CitiesRoute());

  @override
  Widget build(BuildContext context) {
    return AppTextButton.invisible(
      text: t.auth.authLater,
      onTap: () => onTapAuthLater(context),
    );
  }
}
