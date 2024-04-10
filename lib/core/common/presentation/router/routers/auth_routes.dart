import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/router/base_route.dart';

/// Класс роутера для модуля авторизации
@injectable
class AuthRouters implements BaseRouters {
  @override
  AutoRoute get routers => AutoRoute(
        page: AuthWrapperRoute.page,
        maintainState: false,
        children: [
          AutoRoute(page: AuthRoute.page, initial: true),
          AutoRoute(page: OTPRoute.page),
        ],
      );
}
