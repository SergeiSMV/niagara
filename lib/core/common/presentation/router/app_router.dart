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

/// Класс [AppRouter] роутера приложения. Содержит все модули и их маршруты.
@AutoRouterConfig()
@singleton
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        SplashRouters.routers,
        AuthRouters.routers,
        LocationsRouters.routers,
        AutoRoute(
          page: NavigationRoute.page,
          guards: [
            LocationsRouters.cityGuard,
          ],
          children: [
            HomeRouters.routers,
            CatalogRouters.routers,
            CartRouters.routers,
            ProfileRouters.routers,
            EmptyRouters.routers,
          ],
        ),
      ];

  /// Анимация переходов между экранами приложения.
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();
}
