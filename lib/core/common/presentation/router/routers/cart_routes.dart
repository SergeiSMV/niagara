import 'package:auto_route/auto_route.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';

@RoutePage()
class CartNavigatorPage extends AutoRouter {
  const CartNavigatorPage({super.key});
}

/// Класс роутера для модуля Cart (Корзина)
abstract final class CartRouters {
  static AutoRoute get routers => AutoRoute(
        page: CartNavigatorRoute.page,
        children: [
          AutoRoute(page: CartRoute.page, initial: true),
        ],
      );
}
