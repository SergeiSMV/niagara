import 'package:auto_route/auto_route.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';

/// Класс роутера для модуля Home (Главная)
abstract final class HomeRouters {
  static AutoRoute get routers => AutoRoute(
        page: HomeWrapperRoute.page,
        initial: true,
        children: [
          AutoRoute(
            page: HomeRoute.page,
            initial: true,
            title: (_, __) => '',
          ),
        ],
      );
}
