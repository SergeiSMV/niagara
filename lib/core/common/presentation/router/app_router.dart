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
import 'package:niagara_app/core/dependencies/di.dart';

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
  List<AutoRoute> get routes => [
        getIt<SplashRouters>().routers,
        getIt<AuthRouters>().routers,
        AutoRoute(
          page: NavigationRoute.page,
          children: [
            getIt<HomeRouters>().routers,
            getIt<CatalogRouters>().routers,
            getIt<CartRouters>().routers,
            getIt<ShopsRouters>().routers,
            getIt<ProfileRouters>().routers,
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
