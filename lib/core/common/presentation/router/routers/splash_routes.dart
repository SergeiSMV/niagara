import 'package:auto_route/auto_route.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';

/// Класс роутера для модуля Cart (Корзина)
abstract final class SplashRouters {
  static AutoRoute get routers => AutoRoute(
        page: SplashWrapperRoute.page,
        initial: true,
        children: [
          AutoRoute(page: SplashRoute.page, initial: true),
        ],
      );
}
