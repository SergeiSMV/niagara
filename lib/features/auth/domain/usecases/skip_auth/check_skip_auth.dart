import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/auth/domain/repositories/skip_auth_repository.dart';

/// UseCase для проверки пропущена ли авторизация
@injectable
class CheckSkipAuthUseCase extends UseCase<bool, NoParams> {
  /// Конструктор UseCase. Принимает репозиторий [ISkipAuthRepository]
  /// для работы с флагом пропуска авторизации.
  CheckSkipAuthUseCase({
    required ISkipAuthRepository repository,
  }) : _repository = repository;

  final ISkipAuthRepository _repository;

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return _repository.checkSkipAuth();
  }
}
