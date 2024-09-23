import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/enums/onboarding_step.dart';
import 'package:niagara_app/features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'package:niagara_app/features/onboarding/presentation/widgets/onboarding_bottom_buttons.dart';
import 'package:niagara_app/features/onboarding/presentation/widgets/onboarding_step_widget.dart';
import 'package:niagara_app/features/splash/presentation/cubit/splash_cubit.dart';

/// Страница онбоодинга.
///
/// Запрашивает разрешения на доступ к геолокации и отправку уведомлений.
@RoutePage()
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  /// Обработчик состояния онбординга.
  void _stateListener(BuildContext context, OnboardingStep step) {
    if (step == OnboardingStep.finished) {
      context.read<OnboardingCubit>().onFinished();
      context.read<SplashCubit>().onCheckAuth();
      context.maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    return BlocConsumer<OnboardingCubit, OnboardingStep>(
      listener: _stateListener,
      builder: (context, state) {
        final OnboardingStep step;

        // По завершении онбординга не нужно переключать вкладку.
        if (state == OnboardingStep.finished) {
          step = OnboardingStep.geoposition;
        } else {
          step = state;
        }

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: cubit.skipAll,
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          body: OnboardingStepWidget(step: step, key: ValueKey(step)),
          bottomNavigationBar: OnboardingBottomButtonsWidget(step: step),
        );
      },
    );
  }
}
