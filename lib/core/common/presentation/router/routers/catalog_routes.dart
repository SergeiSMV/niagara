import 'package:auto_route/auto_route.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Класс роутера для модуля Catalog (Каталог)
abstract final class CatalogRouters {
  static AutoRoute get routers => AutoRoute(
        page: CatalogWrapper.page,
        children: [
          AutoRoute(
            page: CatalogRoute.page,
            initial: true,
            title: (_, __) => t.routes.catalog,
          ),
          AutoRoute(
            page: GroupsRoute.page,
            title: (_, __) => t.catalog.categories,
          ),
          AutoRoute(
            page: CategoryWrapperRoute.page,
            children: [
              AutoRoute(page: CategoryRoute.page),
              AutoRoute(
                page: FiltersRoute.page,
                title: (_, __) => t.catalog.filter,
              ),
            ],
          ),
          AutoRoute(
            page: ProductRoute.page,
          ),
          AutoRoute(
            page: RecommendsRoute.page,
          ),
          AutoRoute(
            page: CatalogSearchRoute.page,
          ),
        ],
      );
}
