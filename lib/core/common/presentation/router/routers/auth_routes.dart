import 'package:auto_route/auto_route.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Класс роутера для модуля авторизации
abstract final class AuthRouters {
  static AutoRoute get routers => AutoRoute(
        page: AuthWrapper.page,
        maintainState: false,
        children: [
          AutoRoute(
            page: AuthRoute.page,
            initial: true,
            title: (_, __) => t.auth.enterPhone,
          ),
          AutoRoute(
            page: OTPRoute.page,
            title: (_, __) => t.auth.confirmNumber,
          ),
        ],
      );
}
