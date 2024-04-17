import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/router/base_route.dart';

@RoutePage()
class ProfileNavigatorPage extends AutoRouter {
  const ProfileNavigatorPage({super.key});
}

/// Класс роутера для модуля Cart (Корзина)
@lazySingleton
class ProfileRouters implements BaseRouters {
  @override
  AutoRoute get routers => AutoRoute(
        page: ProfileNavigatorRoute.page,
        children: [
          AutoRoute(page: ProfileRoute.page, initial: true),
        ],
      );
}
