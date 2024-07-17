import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/user/domain/repositories/profile_repository.dart';

@injectable
class LogoutUseCase extends BaseUseCase<void, void> {
  LogoutUseCase(this._repository);

  final IProfileRepository _repository;

  @override
  Future<Either<Failure, void>> call(_) => _repository.logout();
}
