import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/auth/domain/repositories/auth_repository.dart';

/// Пропускает авторизацию.
///
/// Возвращает:
/// - [void] если авторизация была пропущена.
/// - [Failure] если авторизация не была пропущена.
@injectable
class SkipAuthUseCase extends UseCase<void, NoParams> {
  SkipAuthUseCase({
    required IAuthRepository repository,
  }) : _repository = repository;

  final IAuthRepository _repository;

  @override
  Future<Either<Failure, void>> call([NoParams? params]) =>
      _repository.skipAuth();
}
