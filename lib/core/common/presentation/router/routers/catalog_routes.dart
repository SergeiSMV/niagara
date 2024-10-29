import 'package:auto_route/auto_route.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/router/routers/loyalty_program_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/order_placing_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/product_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/profile_routes.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

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
          AutoRoute(page: RecommendsRoute.page),
          ProfileRoutes.routes,
          OrderPlacingRoutes.routes,
          LoyaltyProgramRoutes.routes,
          AutoRoute(page: CatalogSearchRoute.page),
        ],
      );
}
