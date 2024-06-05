import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/features/authorization/phone_auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:niagara_app/features/authorization/phone_auth/presentation/bloc/countdown_timer_cubit/countdown_timer_cubit.dart';
import 'package:niagara_app/features/authorization/phone_auth/presentation/widgets/otp_code_widget.dart';
import 'package:niagara_app/features/authorization/phone_auth/presentation/widgets/otp_title_widget.dart';
import 'package:niagara_app/features/authorization/phone_auth/presentation/widgets/resend_code_widget.dart';

/// Страница для ввода кода подтверждения.
@RoutePage()
class OTPPage extends StatelessWidget implements AutoRouteWrapper {
  const OTPPage({
    required String phoneNumber,
    super.key,
  }) : _phoneNumber = phoneNumber;

  final String _phoneNumber;

  void _navigateToMain(BuildContext context) =>
      context.replaceRoute(const NavigationRoute());

  void _resetTimer(BuildContext context) =>
      context.read<CountdownTimerCubit>().startTimer();

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
        create: (_) => CountdownTimerCubit()..startTimer(),
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) => state.maybeWhen(
        otpSuccess: () => _navigateToMain(context),
        otpChangeError: () => _resetTimer(context),
        orElse: () => null,
      ),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBarWidget(),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: AppInsets.kHorizontal16,
                child: Column(
                  children: [
                    OTPTitleWidget(phoneNumber: _phoneNumber),
                    const OTPCodeWidget(),
                    const Spacer(),
                    const ReSendCodeWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
