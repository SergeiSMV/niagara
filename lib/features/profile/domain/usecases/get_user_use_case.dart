import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/domain/models/user.dart';
import 'package:niagara_app/features/profile/domain/repositories/profile_repository.dart';

@injectable
class GetUserUseCase extends BaseUseCase<User, NoParams> {
  GetUserUseCase({
    required IProfileRepository userRepository,
  }) : _repository = userRepository;

  final IProfileRepository _repository;

  @override
  Future<Either<Failure, User>> call([NoParams? params]) =>
      _repository.getUser();
}
