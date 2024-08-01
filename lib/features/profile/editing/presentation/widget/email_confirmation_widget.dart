import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/features/profile/editing/presentation/bloc/email_confirmation_bloc/email_confirmation_bloc.dart';
import 'package:niagara_app/features/profile/editing/presentation/bloc/profile_editing_cubit/profile_editing_cubit.dart';
import 'package:niagara_app/features/profile/editing/presentation/widget/email_code_form.dart';
import 'package:niagara_app/features/profile/editing/presentation/widget/email_form.dart';

class EmailConfirmationWidget extends StatelessWidget {
  const EmailConfirmationWidget({
    super.key,
    this.initialEmail,
    required this.editCubit,
  });

  /// Email, который будет отображён в поле ввода. Используется в случае, если
  /// пользователь уже вводил email, но не закончил этот процесс.
  final String? initialEmail;

  /// Кубит для редактирования профиля.
  final ProfileEditingCubit editCubit;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<EmailConfirmationBloc>()),
        BlocProvider.value(value: editCubit),
      ],
      child: _Content(initialEmail: initialEmail),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.initialEmail,
  });

  final String? initialEmail;

  void onConfirmed(BuildContext context, String email) => context
    ..read<ProfileEditingCubit>().updateUserData(email: email)
    ..maybePop();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kHorizontal16 + AppInsets.kVertical24,
      child: BlocListener<EmailConfirmationBloc, EmailConfirmationState>(
        listener: (_, state) => state.maybeWhen(
          codeConfirmed: (email) => onConfirmed(context, email),
          orElse: () => null,
        ),
        child: BlocBuilder<EmailConfirmationBloc, EmailConfirmationState>(
          builder: (context, state) => state.maybeWhen(
            initial: () => EnterEmailForm(initialEmail: initialEmail),
            codeSent: (email) => EmailCodeForm(email: email),
            orElse: AppCenterLoader.new,
          ),
        ),
      ),
    );
  }
}
