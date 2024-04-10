import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/router/base_route.dart';

/// Страница навигации для модуля Cart (Корзина)
@RoutePage()
class CartNavigatorPage extends AutoRouter {
  /// Конструктор страницы навигации
  const CartNavigatorPage({super.key});
}

/// Класс роутера для модуля Cart (Корзина)
@lazySingleton
class CartRouters implements BaseRouters {
  @override
  AutoRoute get routers => AutoRoute(
        page: CartNavigatorRoute.page,
        children: [
          AutoRoute(page: CartRoute.page, initial: true),
        ],
      );
}
