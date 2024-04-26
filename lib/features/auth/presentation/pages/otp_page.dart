import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:niagara_app/features/auth/presentation/bloc/countdown_timer_cubit/countdown_timer_cubit.dart';
import 'package:niagara_app/features/auth/presentation/widgets/otp_code_widget.dart';
import 'package:niagara_app/features/auth/presentation/widgets/otp_title_widget.dart';
import 'package:niagara_app/features/auth/presentation/widgets/resend_code_widget.dart';

/// Страница для ввода кода подтверждения.
@RoutePage()
class OTPPage extends StatelessWidget {
  const OTPPage({
    required String phoneNumber,
    super.key,
  }) : _phoneNumber = phoneNumber;

  final String _phoneNumber;

  Future<void> _navigateToMain(BuildContext context) =>
      context.replaceRoute(const NavigationRoute());

  void _resetTimer(BuildContext context) =>
      context.read<CountdownTimerCubit>().startTimer();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) => state.maybeWhen(
        otpSuccess: () => _navigateToMain(context),
        otpChangeError: () => _resetTimer(context),
        orElse: () => null,
      ),
      child: Scaffold(
        appBar: const AppBarWidget(),
        body: Column(
          children: [
            OTPTitleWidget(phoneNumber: _phoneNumber),
            const OTPCodeWidget(),
            const Spacer(),
            const ReSendCodeWidget(),
          ],
        ).paddingSymmetric(horizontal: AppConst.kCommon16),
      ),
    );
  }
}
