import 'package:auto_route/auto_route.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/auth/domain/usecases/check_auth_user.dart';
import 'package:niagara_app/features/auth/domain/usecases/skip_auth/check_skip_auth.dart';

/// Абстрактный Guard для авторизации пользователя или проверки на пропуск
/// авторизации. Проверяет авторизацию пользователя и перенаправляет на
/// экран авторизации, если пользователь не авторизован.
abstract class _AuthGuard extends AutoRouteGuard {
  _AuthGuard({
    required UseCase<bool, NoParams> useCase,
  }) : _useCase = useCase;

  final UseCase<bool, NoParams> _useCase;

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final isSkipAuth = await _useCase
        .call(const NoParams())
        .fold((_) => false, (skip) => skip);

    if (isSkipAuth) {
      resolver.next();
    } else {
      await resolver.redirect(const AuthRoute());
    }
  }
}

/// Guard для проверки пропуска авторизации
@injectable
class SkipAuthGuard extends _AuthGuard {
  /// Создает объект Guard для проверки пропуска авторизации.
  SkipAuthGuard({
    required CheckSkipAuthUseCase checkSkipAuthUseCase,
  }) : super(useCase: checkSkipAuthUseCase);
}

/// Guard для проверки авторизации
@injectable
class AuthGuard extends _AuthGuard {
  /// Создает объект Guard для проверки авторизации.
  AuthGuard({
    required CheckAuthUserUseCase checkAuthUserUseCase,
  }) : super(useCase: checkAuthUserUseCase);
}
