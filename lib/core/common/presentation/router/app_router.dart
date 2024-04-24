import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/router/routers/auth_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/cart_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/catalog_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/home_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/location_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/profile_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/shops_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/splash_routes.dart';
import 'package:niagara_app/features/location/presentation/location_guard.dart';

/// Класс [AppRouter] роутера приложения. Содержит все модули и их маршруты.
@AutoRouterConfig()
@singleton
class AppRouter extends $AppRouter {
  AppRouter({
    required SplashRouters splashRouters,
    required AuthRouters authRouters,
    required HomeRouters homeRouters,
    required CatalogRouters catalogRouters,
    required CartRouters cartRouters,
    required ShopsRouters shopsRouters,
    required ProfileRouters profileRouters,
    required LocationsRouters locationsRouters,
    required LocationGuard locationGuard,
  })  : _splashRouters = splashRouters,
        _authRouters = authRouters,
        _homeRouters = homeRouters,
        _catalogRouters = catalogRouters,
        _cartRouters = cartRouters,
        _shopsRouters = shopsRouters,
        _profileRouters = profileRouters,
        _locationsRouters = locationsRouters,
        _locationGuard = locationGuard;

  final SplashRouters _splashRouters;
  final AuthRouters _authRouters;
  final HomeRouters _homeRouters;
  final CatalogRouters _catalogRouters;
  final CartRouters _cartRouters;
  final ShopsRouters _shopsRouters;
  final ProfileRouters _profileRouters;
  final LocationsRouters _locationsRouters;
  final LocationGuard _locationGuard;

  @override
  List<AutoRoute> get routes => [
        _splashRouters.routers,
        _authRouters.routers,
        AutoRoute(
          page: NavigationRoute.page,
          guards: [
            _locationGuard,
          ],
          children: [
            _homeRouters.routers,
            _catalogRouters.routers,
            _cartRouters.routers,
            _shopsRouters.routers,
            _profileRouters.routers,
          ],
        ),
        _locationsRouters.routers,
      ];

  /// Анимация переходов между экранами приложения.
  @override
  RouteType get defaultRouteType {
    return RouteType.custom(
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
