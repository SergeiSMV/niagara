import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:niagara_app/core/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/splash/presentation/cubit/splash_cubit.dart';

/// Страница загрузки приложения с анимацией логотипа
@RoutePage()
class SplashPage extends HookWidget {
  /// Используется Cubit для управления состоянием после загрузки анимации
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Контроллер анимации
    final mainAnimationCtrl = useAnimationController();
    // Управление прозрачностью
    final opacity = useState<double>(0);

    // Запускаем анимацию прозрачности спустя определенное время после начала
    // основной анимации
    useEffect(
      () {
        final timer = Timer(
          AppConst.kSplashLogoDuration,
          () => opacity.value = 1,
        );
        return timer.cancel;
      },
      [mainAnimationCtrl],
    );

    return BlocProvider(
      create: (_) => SplashCubit(),
      child: BlocConsumer<SplashCubit, bool>(
        listener: (context, state) {
          // TODO(Oleg): Дополнить ожиданием загрузки данных.
          // Переход на главный экран при готовности.
          if (state) context.router.replace(const NavigationRoute());
        },
        builder: (context, state) => FittedBox(
          fit: BoxFit.cover,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Assets.lottie.splashScreen.lottie(
                controller: mainAnimationCtrl,
                onLoaded: (composition) => mainAnimationCtrl
                  ..duration = composition.duration
                  ..forward().whenComplete(
                    context.read<SplashCubit>().readyToNavigate,
                  ),
              ),
              AnimatedOpacity(
                opacity: opacity.value,
                duration: Durations.medium1,
                child: Assets.images.logo.svg(),
              ),
              Positioned(
                bottom: AppConst.kLoaderBottomOffset,
                child: AnimatedOpacity(
                  opacity: state ? 1 : 0,
                  duration: Durations.long2,
                  child: Assets.lottie.loadCircleWhite.lottie(
                    repeat: true,
                    width: AppConst.kLoaderSize,
                    height: AppConst.kLoaderSize,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
