import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/authorization/base_token/domain/repositories/token_repository.dart';
import 'package:niagara_app/features/authorization/phone_auth/domain/repositories/auth_repository.dart';
import 'package:niagara_app/features/profile/user/domain/models/user.dart';
import 'package:niagara_app/features/profile/user/domain/repositories/profile_repository.dart';

@injectable
class DeleteUserUseCase extends BaseUseCase<void, User> {
  DeleteUserUseCase(
    this._profileRepository,
    this._authRepository,
    this._tokenRepository,
  );

  final IProfileRepository _profileRepository;
  final IAuthRepository _authRepository;
  final ITokenRepository _tokenRepository;

  @override
  Future<Either<Failure, void>> call(User params) async {
    return _profileRepository.deleteUser(user: params).either(
          (failure) => throw failure,
          (_) => _authRepository.logout().either(
                (failure) => throw failure,
                (_) => _tokenRepository.deleteToken().either(
                      (failure) => throw failure,
                      // Нужно создать токен заново, т.к. он потребуется сразу после
                      // перезагрузки приложения.
                      (_) => _tokenRepository.createToken(),
                    ),
              ),
        );
  }
}
