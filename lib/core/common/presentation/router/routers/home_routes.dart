import 'package:auto_route/auto_route.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';

@RoutePage()
class HomeNavigatorPage extends AutoRouter {
  const HomeNavigatorPage({super.key});
}

/// Класс роутера для модуля Home (Главная)
abstract final class HomeRouters {
  static AutoRoute get routers => AutoRoute(
        page: HomeNavigatorRoute.page,
        initial: true,
        children: [
          AutoRoute(page: HomeRoute.page, initial: true),
        ],
      );
}
