import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/auth_status.dart';
import 'package:niagara_app/features/auth/domain/repositories/auth_repository.dart';

/// UseCase для установки статуса авторизации
@injectable
class SetAuthStatusUseCase extends UseCase<void, SetAuthStatusParams> {
  /// Конструктор UseCase. Принимает репозиторий [IAuthRepository]
  SetAuthStatusUseCase({
    required IAuthRepository repository,
  }) : _repository = repository;

  final IAuthRepository _repository;

  @override
  Future<Either<Failure, void>> call(SetAuthStatusParams params) {
    return _repository.onSetAuthStatus(status: params.status);
  }
}

/// Параметры для установки статуса авторизации
class SetAuthStatusParams {
  /// Конструктор параметров для установки статуса авторизации
  SetAuthStatusParams({
    required this.status,
  });

  /// Статус авторизации
  final AuthenticatedStatus status;
}
