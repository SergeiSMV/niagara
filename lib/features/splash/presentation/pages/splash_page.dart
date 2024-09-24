import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:niagara_app/features/splash/presentation/widgets/bottom_loader_widget.dart';

/// Страница загрузки приложения с анимацией логотипа
@RoutePage()
class SplashPage extends HookWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Контроллер анимации
    final mainAnimationCtrl = useAnimationController();

    // Управление прозрачностью
    final opacity = useState<double>(0);

    // Запускаем анимацию прозрачности спустя определенное
    // время после начала основной анимации
    useEffect(
      () {
        final timer = Timer(
          AppConstants.kSplashLogoDuration,
          () => opacity.value = AppSizes.kGeneral1,
        );
        return timer.cancel;
      },
      [mainAnimationCtrl],
    );

    void onLoaded(LottieComposition composition) => mainAnimationCtrl
      ..duration = composition.duration
      ..forward().whenComplete(context.read<SplashCubit>().onCheckOnboarding);

    void readyToOnboard() => context.pushRoute(const OnboardingRoute());

    void readyToAuth() => context.replaceRoute(const AuthWrapper());

    void readyToMain() => context.replaceRoute(const NavigationRoute());

    return BlocListener<SplashCubit, SplashState>(
      listener: (_, state) => state.maybeWhen(
        readyToAuth: readyToAuth,
        readyToMain: readyToMain,
        readyToOnboarding: readyToOnboard,
        orElse: () => null,
      ),
      child: FittedBox(
        fit: BoxFit.cover,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Assets.lottie.splashScreen.lottie(
              controller: mainAnimationCtrl,
              onLoaded: onLoaded,
            ),
            AnimatedOpacity(
              opacity: opacity.value,
              duration: Durations.medium1,
              child: Assets.images.logo.svg(),
            ),
            const BottomLoaderWidget(),
          ],
        ),
      ),
    );
  }
}
