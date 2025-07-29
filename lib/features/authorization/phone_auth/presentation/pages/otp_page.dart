import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common/presentation/router/app_router.gr.dart';
import '../../../../../core/common/presentation/widgets/app_bar.dart';
import '../../../../../core/dependencies/di.dart';
import '../../../../../core/utils/constants/app_boxes.dart';
import '../../../../../core/utils/constants/app_insets.dart';
import '../../../../home/presentation/widgets/support_button.dart';
import '../../../../support/presentation/support_chat_state.dart';
import '../../../../support/presentation/support_cubit.dart';
import '../bloc/auth_bloc/auth_bloc.dart';
import '../bloc/countdown_timer_cubit/countdown_timer_cubit.dart';
import '../widgets/otp_code_widget.dart';
import '../widgets/otp_loading_widget.dart';
import '../widgets/otp_title_widget.dart';
import '../widgets/resend_code_widget.dart';

/// Страница для ввода кода подтверждения.
@RoutePage()
class OTPPage extends StatelessWidget implements AutoRouteWrapper {
  const OTPPage({
    required String phoneNumber,
    super.key,
  }) : _phoneNumber = phoneNumber;

  final String _phoneNumber;

  void _navigateToMain(BuildContext context) =>
      context.router.navigate(const NavigationRoute());

  void _resetTimer(BuildContext context) =>
      context.read<CountdownTimerCubit>().startTimer();

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
        create: (_) => CountdownTimerCubit()..startTimer(),
        child: this,
      );

  @override
  Widget build(BuildContext context) => BlocProvider(
        // ignore: discarded_futures
        create: (_) => getIt<SupportCubit>()..getUserCredentials(),
        child: BlocProvider.value(
          value: getIt<AuthBloc>(),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) => state.maybeWhen(
              otpSuccess: () {
                _navigateToMain(context);
                return;
              },
              otpChangeError: () => _resetTimer(context),
              orElse: () => null,
            ),
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverAppBarWidget(
                    actions: [
                      BlocBuilder<SupportCubit, SupportChatState>(
                        builder: (_, state) => state.isReady
                            ? const SupportButton()
                            : const SizedBox.shrink(),
                      ),
                      AppBoxes.kWidth16,
                    ],
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: AppInsets.kHorizontal16,
                      child: Column(
                        children: [
                          OTPTitleWidget(phoneNumber: _phoneNumber),
                          const OTPCodeWidget(),
                          const Spacer(),
                          const OtpLoadingWidget(),
                          const Spacer(),
                          const ReSendCodeWidget(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
