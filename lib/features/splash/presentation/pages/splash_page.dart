import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:niagara_app/core/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

@RoutePage()
class SplashPage extends HookWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController();
    return FittedBox(
      fit: BoxFit.cover,
      child: Lottie.asset(
        Assets.lottie.splashScreenLottie,
        controller: animationController,
        onLoaded: (composition) => animationController
          ..duration = composition.duration
          ..forward().whenComplete(
            () => context.router.replace(const NavigationRoute()),
          ),
      ),
    );
  }
}
