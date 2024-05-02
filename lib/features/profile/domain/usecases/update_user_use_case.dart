import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/domain/models/user.dart';
import 'package:niagara_app/features/profile/domain/repositories/profile_repository.dart';

@injectable
class UpdateUserUseCase extends BaseUseCase<void, User> {
  UpdateUserUseCase({
    required IProfileRepository userRepository,
  }) : _repository = userRepository;

  final IProfileRepository _repository;

  @override
  Future<Either<Failure, void>> call(User params) =>
      _repository.updateUser(params);
}
