import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/authorization/base_token/domain/repositories/token_repository.dart';
import 'package:niagara_app/features/authorization/phone_auth/domain/repositories/auth_repository.dart';

@injectable
class LogoutUseCase extends BaseUseCase<void, NoParams> {
  LogoutUseCase(
    this._authRepository,
    this._tokenRepository,
  );

  final IAuthRepository _authRepository;
  final ITokenRepository _tokenRepository;

  @override
  Future<Either<Failure, void>> call(NoParams _) async {
    return _authRepository.logout().either(
          (failure) => failure,
          (_) => _tokenRepository.deleteToken(),
        );
  }
}
