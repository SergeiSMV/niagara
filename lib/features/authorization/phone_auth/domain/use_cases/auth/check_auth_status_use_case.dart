import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/auth_status.dart';
import 'package:niagara_app/features/authorization/phone_auth/domain/repositories/auth_repository.dart';

/// Проверяет статус авторизации.
///
/// Возвращает:
/// - [AuthenticatedStatus] если статус авторизации был получен.
/// - [Failure] если статус авторизации не был получен.
@injectable
class CheckAuthStatusUseCase
    extends BaseUseCase<AuthenticatedStatus, NoParams> {
  CheckAuthStatusUseCase(this._repository);

  final IAuthRepository _repository;

  @override
  Future<Either<Failure, AuthenticatedStatus>> call([NoParams? params]) =>
      _repository.checkAuthStatus();
}
