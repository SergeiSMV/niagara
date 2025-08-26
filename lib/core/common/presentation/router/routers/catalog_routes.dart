import 'package:auto_route/auto_route.dart';

import '../../../../utils/gen/strings.g.dart';
import '../app_router.gr.dart';
import 'loyalty_program_routes.dart';
import 'order_placing_routes.dart';
import 'payment_routes.dart';
import 'product_routes.dart';

/// Класс роутера для модуля Catalog (Каталог)
abstract final class CatalogRoutes {
  static AutoRoute get routes => AutoRoute(
        page: CatalogWrapper.page,
        children: [
          AutoRoute(
            page: CatalogRoute.page,
            initial: true,
            title: (_, __) => t.routes.catalog,
          ),
          AutoRoute(
            page: GroupsRoute.page,
            title: (_, __) => t.catalog.categories,
          ),
          AutoRoute(
            page: CategoryWrapperRoute.page,
            children: [
              AutoRoute(page: CategoryRoute.page),
              AutoRoute(
                page: FiltersRoute.page,
                title: (_, __) => t.catalog.filter,
              ),
            ],
          ),
          ProductRoutes.routes,
          PaymentRoutes.routes,
          AutoRoute(page: RecommendsRoute.page),
          OrderPlacingRoutes.routes,
          LoyaltyProgramRoutes.routes,
          AutoRoute(page: CatalogSearchRoute.page),
        ],
      );
}
