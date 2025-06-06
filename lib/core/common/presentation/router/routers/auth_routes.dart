import 'package:auto_route/auto_route.dart';

import '../../../../utils/gen/strings.g.dart';
import '../app_router.gr.dart';

/// Класс роутера для модуля авторизации
abstract final class AuthRoutes {
  static AutoRoute get routes => AutoRoute(
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
          AutoRoute(page: PolicyRoute.page),
        ],
      );
}
