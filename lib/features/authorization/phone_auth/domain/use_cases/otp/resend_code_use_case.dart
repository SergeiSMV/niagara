import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/authorization/phone_auth/domain/repositories/auth_repository.dart';

/// Повторно отправляет код подтверждения.
///
/// Возвращает:
/// - [void] если код подтверждения был отправлен.
/// - [Failure] если код подтверждения не был отправлен.
@injectable
class ResendPhoneUseCase extends BaseUseCase<void, NoParams> {
  ResendPhoneUseCase(this._repository);

  final IAuthRepository _repository;

  @override
  Future<Either<Failure, void>> call([NoParams? params]) =>
      _repository.resendCode();
}
