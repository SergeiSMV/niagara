import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/router/base_route.dart';

@RoutePage()
class ShopsNavigatorPage extends AutoRouter {
  const ShopsNavigatorPage({super.key});
}

/// Класс роутера для модуля Cart (Корзина)
@lazySingleton
class ShopsRouters implements BaseRouters {
  @override
  AutoRoute get routers => AutoRoute(
        page: ShopsNavigatorRoute.page,
        children: [
          AutoRoute(page: ShopsRoute.page, initial: true),
        ],
      );
}
