import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/user/domain/models/user.dart';
import 'package:niagara_app/features/profile/user/domain/repositories/profile_repository.dart';

@injectable
class UpdateUserUseCase extends BaseUseCase<void, User> {
  UpdateUserUseCase(this._repository);

  final IProfileRepository _repository;

  @override
  Future<Either<Failure, void>> call(User params) =>
      _repository.updateUser(params);
}
