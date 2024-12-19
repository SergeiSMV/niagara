import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/router/routers/auth_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/cart_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/catalog_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/empty_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/home_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/location_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/profile_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/splash_routes.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Класс [AppRouter] роутера приложения. Содержит все модули и их маршруты.
@AutoRouterConfig()
@singleton
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        SplashRouters.routes,
        AuthRoutes.routes,
        LocationsRoutes.routes,
        AutoRoute(
          page: NavigationRoute.page,
          guards: [
            LocationsRoutes.cityGuard,
            LocationsRoutes.addressesGuard,
          ],
          children: [
            HomeRoutes.routes,
            CatalogRoutes.routes,
            CartRoutes.routes,
            EmptyRouters.routers,
            ProfileRoutes.routes,
          ],
        ),
        AutoRoute(page: StorySlidesWrapper.page),
        AutoRoute(page: PolicyRoute.page),
        AutoRoute(
          page: OTPRoute.page,
          title: (_, __) => t.auth.confirmNumber,
        ),
        CatalogRoutes.routes,
        // AutoRoute(
        //   page: CategoryWrapperRoute.page,
        //   children: [
        //     AutoRoute(page: CategoryRoute.page),
        //     AutoRoute(
        //       page: FiltersRoute.page,
        //       title: (_, __) => t.catalog.filter,
        //     ),
        //   ],
        // ),
      ];

  /// Анимация переходов между экранами приложения.
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();
}
