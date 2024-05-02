import 'package:auto_route/auto_route.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';

/// Класс роутера для модуля Cart (Корзина)
abstract final class ProfileRouters {
  static AutoRoute get routers => AutoRoute(
        page: ProfileWrapper.page,
        children: [
          AutoRoute(page: ProfileRoute.page, initial: true),
        ],
      );
}
