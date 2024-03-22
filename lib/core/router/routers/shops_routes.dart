import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/router/app_router.gr.dart';
import 'package:niagara_app/core/router/base_route.dart';

/// Страница навигации для модуля Shops (Магазины)
@RoutePage()
class ShopsNavigatorPage extends AutoRouter {
  /// Конструктор страницы навигации
  const ShopsNavigatorPage({super.key});
}

/// Класс роутера для модуля Cart (Корзина)
@singleton
class ShopsRouters implements BaseRouters {
  @override
  AutoRoute get routers => AutoRoute(
        page: ShopsNavigatorRoute.page,
        children: [
          AutoRoute(page: ShopsRoute.page, initial: true),
        ],
      );
}
