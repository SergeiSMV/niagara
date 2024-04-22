import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/auth_status.dart';
import 'package:niagara_app/features/auth/domain/repositories/auth_repository.dart';

/// Проверяет статус авторизации.
///
/// Возвращает:
/// - [AuthenticatedStatus] если статус авторизации был получен.
/// - [Failure] если статус авторизации не был получен.
@injectable
class CheckAuthStatusUseCase
    extends BaseUseCase<AuthenticatedStatus, NoParams> {
  CheckAuthStatusUseCase({
    required IAuthRepository repository,
  }) : _repository = repository;

  final IAuthRepository _repository;

  @override
  Future<Either<Failure, AuthenticatedStatus>> call([NoParams? params]) =>
      _repository.checkAuthStatus();
}
