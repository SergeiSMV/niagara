import 'package:auto_route/auto_route.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/router/routers/loyalty_program_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/order_placing_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/order_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/payment_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/product_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/profile_routes.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Класс роутера для модуля Home (Главная)
abstract final class HomeRoutes {
  static AutoRoute get routes => AutoRoute(
        page: HomeWrapperRoute.page,
        children: [
          AutoRoute(
            page: HomeRoute.page,
            initial: true,
            title: (_, __) => '',
          ),
          AutoRoute(
            page: PromotionsTabRoute.page,
            children: [
              AutoRoute(
                page: PromotionsRoute.page,
                title: (_, __) => t.promos.promotions,
              ),
            ],
          ),
          AutoRoute(page: NotificationsRoute.page),
          AutoRoute(page: OneNotificationRoute.page),
          ProductRoutes.routes,
          AutoRoute(page: RecommendsRoute.page),
          ProfileRoutes.routes,
          PaymentRoutes.routes,
          OrderPlacingRoutes.routes,
          LoyaltyProgramRoutes.routes,
          OrderRoutes.routes,
        ],
      );
}
