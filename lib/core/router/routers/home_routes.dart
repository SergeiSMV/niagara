import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/router/app_router.gr.dart';
import 'package:niagara_app/core/router/base_route.dart';

/// Страница навигации для модуля Home (Главная)
@RoutePage()
class HomeNavigatorPage extends AutoRouter {
  /// Конструктор страницы навигации
  const HomeNavigatorPage({super.key});
}

/// Класс роутера для модуля Home (Главная)
@singleton
class HomeRouters implements BaseRouters {
  @override
  AutoRoute get routers => AutoRoute(
        page: HomeNavigatorRoute.page,
        initial: true,
        children: [
          AutoRoute(page: HomeRoute.page, initial: true),
          AutoRoute(page: Home2Route.page),
        ],
      );
}
