import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/router/base_route.dart';

@RoutePage()
class HomeNavigatorPage extends AutoRouter {
  const HomeNavigatorPage({super.key});
}

/// Класс роутера для модуля Home (Главная)
@lazySingleton
class HomeRouters implements BaseRouters {
  @override
  AutoRoute get routers => AutoRoute(
        page: HomeNavigatorRoute.page,
        initial: true,
        children: [
          AutoRoute(page: HomeRoute.page, initial: true),
        ],
      );
}
