import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/router/app_router.gr.dart';
import 'package:niagara_app/core/router/base_route.dart';

/// Страница навигации для модуля Catalog (Каталог)
@RoutePage()
class CatalogNavigatorPage extends AutoRouter {
  /// Конструктор страницы навигации
  const CatalogNavigatorPage({super.key});
}

/// Класс роутера для модуля Catalog (Каталог)
@singleton
class CatalogRouters implements BaseRouters {
  @override
  AutoRoute get routers => AutoRoute(
        page: CatalogNavigatorRoute.page,
        children: [
          AutoRoute(page: CatalogRoute.page, initial: true),
        ],
      );
}
