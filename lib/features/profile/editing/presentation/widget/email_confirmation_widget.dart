import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/features/authorization/phone_auth/presentation/bloc/countdown_timer_cubit/countdown_timer_cubit.dart';
import 'package:niagara_app/features/profile/editing/presentation/bloc/email_confirmation_bloc/email_confirmation_bloc.dart';
import 'package:niagara_app/features/profile/editing/presentation/bloc/profile_editing_cubit/profile_editing_cubit.dart';
import 'package:niagara_app/features/profile/editing/presentation/widget/email_code_form.dart';
import 'package:niagara_app/features/profile/editing/presentation/widget/email_form.dart';

/// Виджет для подтверждения email.
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
        BlocProvider(create: (_) => getIt<CountdownTimerCubit>()),
      ],
      child: _Content(initialEmail: initialEmail, editCubit: editCubit),
    );
  }
}

class _Content extends StatefulWidget {
  const _Content({
    required this.initialEmail,
    required this.editCubit,
  });

  final String? initialEmail;
  final ProfileEditingCubit editCubit;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  /// Текущее значение email.
  String? _email;

  @override
  void initState() {
    super.initState();
    _email = widget.initialEmail;
  }

  void _onConfirmed(BuildContext context, String email) {
    widget.editCubit.updateUserData(email: email);
    context.maybePop();
  }

  void _onCodeSent(BuildContext context, String email) {
    _email = email;
    context.read<CountdownTimerCubit>().startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kHorizontal16 + AppInsets.kVertical24,
      child: BlocListener<EmailConfirmationBloc, EmailConfirmationState>(
        listener: (_, state) => state.maybeWhen(
          codeSent: (email) => _onCodeSent(context, email),
          codeConfirmed: (email) => _onConfirmed(context, email),
          orElse: () => null,
        ),
        child: BlocBuilder<EmailConfirmationBloc, EmailConfirmationState>(
          builder: (context, state) => state.maybeWhen(
            initial: () => EnterEmailForm(initialEmail: widget.initialEmail),
            loading: AppCenterLoader.new,
            orElse: () => EmailCodeForm(email: _email ?? ''),
          ),
        ),
      ),
    );
  }
}
