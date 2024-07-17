import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/user/domain/models/user.dart';
import 'package:niagara_app/features/profile/user/domain/repositories/profile_repository.dart';

@injectable
class DeleteUserUseCase extends BaseUseCase<void, User> {
  DeleteUserUseCase(this._repository);

  final IProfileRepository _repository;

  @override
  Future<Either<Failure, void>> call(User params) =>
      _repository.deleteUser(params);
}
