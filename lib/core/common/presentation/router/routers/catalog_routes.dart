import 'package:auto_route/auto_route.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';

@RoutePage()
class CatalogNavigatorPage extends AutoRouter {
  const CatalogNavigatorPage({super.key});
}

/// Класс роутера для модуля Catalog (Каталог)
abstract final class CatalogRouters {
  static AutoRoute get routers => AutoRoute(
        page: CatalogNavigatorRoute.page,
        children: [
          AutoRoute(page: CatalogRoute.page, initial: true),
        ],
      );
}
