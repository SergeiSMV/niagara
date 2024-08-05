import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/user/domain/models/user.dart';

abstract interface class IProfileRepository {
  Future<Either<Failure, User>> getUser();

  Future<Either<Failure, void>> updateUser(User user);

  /// Удаляет пользователя с сервера и из локальной базы данных (по умолчанию).
  ///
  /// [fromRemote] позволяет удалить пользователя только локально, если не нужно
  /// удалять учетную запись с сервера (например, при выходе из аккаунта).
  Future<Either<Failure, void>> deleteUser({
    required User user,
    bool fromRemote = true,
  });

  Future<Either<Failure, void>> sendEmailCode({required String email});

  Future<Either<Failure, void>> confirmEmail({required String code});
}
