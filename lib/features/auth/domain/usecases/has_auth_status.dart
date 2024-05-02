import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/auth/domain/repositories/auth_repository.dart';

@injectable
class HasAuthStatusUseCase extends BaseUseCase<bool, NoParams> {
  HasAuthStatusUseCase({
    required IAuthRepository repository,
  }) : _repository = repository;

  final IAuthRepository _repository;

  @override
  Future<Either<Failure, bool>> call([NoParams? params]) =>
      _repository.checkAuthStatus().fold(
            (failure) => throw failure,
            (status) => Right(status.hasAuth),
          );
}
