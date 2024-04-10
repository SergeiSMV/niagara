import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/router/routers/auth_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/cart_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/catalog_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/home_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/profile_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/shops_routes.dart';
import 'package:niagara_app/core/common/presentation/router/routers/splash_routes.dart';

/// Класс [AppRouter] роутера приложения. Содержит все модули и
/// их маршруты навигации в приложении.
@AutoRouterConfig()
@singleton
class AppRouter extends $AppRouter {
  /// Конструктор роутера приложения [AppRouter] с передачей всех модулей
  /// и их маршрутов навигации.
  AppRouter({
    required SplashRouters splashRouters,
    required AuthRouters authRouters,
    required HomeRouters homeRouters,
    required CatalogRouters catalogRouters,
    required CartRouters cartRouters,
    required ShopsRouters shopsRouters,
    required ProfileRouters profileRouters,
  })  : _splashRouters = splashRouters,
        _authRouters = authRouters,
        _homeRouters = homeRouters,
        _catalogRouters = catalogRouters,
        _cartRouters = cartRouters,
        _shopsRouters = shopsRouters,
        _profileRouters = profileRouters;

  final SplashRouters _splashRouters;
  final AuthRouters _authRouters;
  final HomeRouters _homeRouters;
  final CatalogRouters _catalogRouters;
  final CartRouters _cartRouters;
  final ShopsRouters _shopsRouters;
  final ProfileRouters _profileRouters;

  /// Тип маршрута по умолчанию для приложения. Используется для анимации
  /// переходов между экранами приложения.
  @override
  RouteType get defaultRouteType => const RouteType.custom(
        transitionsBuilder: _transitionsBuilder,
      );

  /// Список всех маршрутов приложения
  @override
  List<AutoRoute> get routes => [
        _splashRouters.routers,
        _authRouters.routers,
        AutoRoute(
          page: NavigationRoute.page,
          children: [
            _homeRouters.routers,
            _catalogRouters.routers,
            _cartRouters.routers,
            _shopsRouters.routers,
            _profileRouters.routers,
          ],
        ),
      ];

  /// Функция для создания анимации перехода между экранами с
  /// использованием [FadeTransition] анимации.
  static Widget _transitionsBuilder(
    BuildContext _,
    Animation<double> animation,
    Animation<double> __,
    Widget child,
  ) =>
      FadeTransition(
        opacity: animation,
        child: child,
      );
}
