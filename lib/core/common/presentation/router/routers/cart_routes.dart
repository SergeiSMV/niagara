import 'package:auto_route/auto_route.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Класс роутера для модуля Cart (Корзина)
abstract final class CartRouters {
  static AutoRoute get routers => AutoRoute(
        page: CartWrapper.page,
        children: [
          AutoRoute(
            page: CartNavigationRoute.page,
            initial: true,
            children: [
              AutoRoute(page: CartRoute.page),
              AutoRoute(page: FavoritesRoute.page),
              AutoRoute(
                page: OrderPlacingRoute.page,
                title: (_, __) => t.orderPlacing.orderPlacing,
              ),
            ],
          ),
        ],
      );
}
