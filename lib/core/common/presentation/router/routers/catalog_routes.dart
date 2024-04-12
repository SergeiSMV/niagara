import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/router/base_route.dart';

@RoutePage()
class CatalogNavigatorPage extends AutoRouter {
  const CatalogNavigatorPage({super.key});
}

@injectable
class CatalogRouters implements BaseRouters {
  @override
  AutoRoute get routers => AutoRoute(
        page: CatalogNavigatorRoute.page,
        children: [
          AutoRoute(page: CatalogRoute.page, initial: true),
        ],
      );
}
