import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/auth_status.dart';
import 'package:niagara_app/features/auth/domain/repositories/auth_repository.dart';

/// UseCase для проверки авторизован ли пользователь
@injectable
class CheckAuthStatusUseCase extends UseCaseNoParams<AuthenticatedStatus> {
  /// Конструктор UseCase. Принимает репозиторий [IAuthRepository]
  CheckAuthStatusUseCase({required IAuthRepository repository})
      : _repository = repository;

  final IAuthRepository _repository;

  @override
  Future<Either<Failure, AuthenticatedStatus>> call() {
    return _repository.onCheckAuthStatus();
  }
}
