import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/user/domain/repositories/profile_repository.dart';

/// Отправляет код подтверждения на заданный email.
@injectable
class SendEmailCodeUseCase extends BaseUseCase<void, SendEmailCodeParams> {
  SendEmailCodeUseCase(this._repository);

  final IProfileRepository _repository;

  @override
  Future<Either<Failure, void>> call(SendEmailCodeParams params) =>
      _repository.sendEmailCode(email: params.email);
}

class SendEmailCodeParams extends Equatable {
  const SendEmailCodeParams({
    required this.email,
  });

  final String email;

  @override
  List<Object?> get props => [email];
}
