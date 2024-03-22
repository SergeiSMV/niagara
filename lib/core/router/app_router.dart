import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/router/app_router.gr.dart';
import 'package:niagara_app/core/router/routers/cart_routes.dart';
import 'package:niagara_app/core/router/routers/catalog_routes.dart';
import 'package:niagara_app/core/router/routers/home_routes.dart';
import 'package:niagara_app/core/router/routers/profile_routes.dart';
import 'package:niagara_app/core/router/routers/shops_routes.dart';

/// Класс [AppRouter] роутера приложения. Содержит все модули и
/// их маршруты навигации в приложении.
@AutoRouterConfig()
@singleton
class AppRouter extends $AppRouter {
  /// Тип маршрута по умолчанию для приложения. Используется для анимации
  /// переходов между экранами приложения.
  @override
  RouteType get defaultRouteType => const RouteType.custom(
        transitionsBuilder: _transitionsBuilder,
      );

  /// Список всех маршрутов приложения
  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(
        initial: true,
        page: NavigationRoute.page,
        children: [
          HomeRouters().routers,
          CatalogRouters().routers,
          CartRouters().routers,
          ShopsRouters().routers,
          ProfileRouters().routers,
        ],
      ),
    ];
  }

  /// Функция для создания анимации перехода между экранами приложения с
  /// использованием [FadeTransition].
  static Widget _transitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      FadeTransition(
        opacity: animation,
        child: child,
      );
}
