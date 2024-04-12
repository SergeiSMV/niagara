import 'package:auto_route/auto_route.dart';
import 'package:either_dart/either.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/enums/auth_status.dart';
import 'package:niagara_app/features/auth/domain/usecases/check_auth_status.dart';

/// [AuthGuard] для проверки авторизации. Если пользователь не авторизован, то
/// перенаправляет на страницу авторизации.
class AuthGuard extends AutoRouteGuard {
  AuthGuard({
    required CheckAuthStatusUseCase authStatusUseCase,
  }) : _authStatusUseCase = authStatusUseCase;

  final CheckAuthStatusUseCase _authStatusUseCase;

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    // Проверка на авторизацию
    final hasAuth = await _authStatusUseCase.call().fold(
          (_) => false,
          (authState) => authState == AuthenticatedStatus.authenticated,
        );

    // Если авторизован, то продолжаем
    if (hasAuth) {
      resolver.next();
    } else {
      // Если не авторизован, то переходим на страницу авторизации
      await resolver.redirect(const AuthRoute());
    }
  }
}
