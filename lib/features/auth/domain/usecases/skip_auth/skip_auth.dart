import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/auth/domain/repositories/skip_auth_repository.dart';

/// UseCase для проверки пропущена ли авторизация
@injectable
class SkipAuthUseCase extends UseCase<void, NoParams> {
  /// Конструктор UseCase. Принимает репозиторий [ISkipAuthRepository]
  /// для работы с флагом пропуска авторизации.
  SkipAuthUseCase({
    required ISkipAuthRepository repository,
  }) : _repository = repository;

  final ISkipAuthRepository _repository;
  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return _repository.skipAuth(skipAuth: true);
  }
}
