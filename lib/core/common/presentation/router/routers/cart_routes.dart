import 'package:auto_route/auto_route.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/router/routers/loyalty_program_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/order_placing_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/payment_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/product_routes.dart';

/// Класс роутера для модуля Cart (Корзина)
abstract final class CartRoutes {
  static AutoRoute get routes => AutoRoute(
        page: CartWrapper.page,
        children: [
          AutoRoute(
            page: CartNavigationRoute.page,
            initial: true,
            children: [
              AutoRoute(page: CartRoute.page),
              AutoRoute(page: FavoritesRoute.page),
            ],
          ),
          ProductRoutes.routes,
          PaymentRoutes.routes,
          LoyaltyProgramRoutes.routes,
          AutoRoute(page: RecommendsRoute.page),
          OrderPlacingRoutes.routes,
        ],
      );
}
