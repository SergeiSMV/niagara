import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/user/domain/models/user.dart';
import 'package:niagara_app/features/profile/user/domain/repositories/profile_repository.dart';

@injectable
class GetUserUseCase extends BaseUseCase<User, NoParams> {
  GetUserUseCase(this._repository);

  final IProfileRepository _repository;

  @override
  Future<Either<Failure, User>> call([NoParams? params]) =>
      _repository.getUser();
}
