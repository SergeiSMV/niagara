import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/authorization/phone_auth/domain/repositories/auth_repository.dart';

@injectable
class HasAuthStatusUseCase extends BaseUseCase<bool, NoParams> {
  HasAuthStatusUseCase(this._repository);

  final IAuthRepository _repository;

  @override
  Future<Either<Failure, bool>> call([NoParams? params]) =>
      _repository.checkAuthStatus().fold(
            (failure) => throw failure,
            (status) => Right(status.hasAuth),
          );
}
