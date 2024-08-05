import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/user/domain/repositories/profile_repository.dart';

/// Проверяет код потверждения для текущего email.
@injectable
class CheckEmailCodeUseCase extends BaseUseCase<void, CheckEmailCodeParams> {
  CheckEmailCodeUseCase(this._repository);

  final IProfileRepository _repository;

  @override
  Future<Either<Failure, void>> call(CheckEmailCodeParams params) =>
      _repository.confirmEmail(code: params.code);
}

class CheckEmailCodeParams extends Equatable {
  const CheckEmailCodeParams({
    required this.code,
  });

  final String code;

  @override
  List<Object?> get props => [code];
}
