import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/user/domain/models/user.dart';

abstract interface class IProfileRepository {
  Future<Either<Failure, User>> getUser();

  Future<Either<Failure, void>> updateUser(User user);

  /// Удаляет пользователя с сервера и из локальной базы данных (по умолчанию).
  ///
  /// [fromRemote] == false позволяет не удалять данные о пользователе на
  /// сервере, если нужно удалить пользователя только из локальной БД.
  Future<Either<Failure, void>> deleteUser({
    required User user,
    bool fromRemote = true,
  });

  Future<Either<Failure, void>> sendEmailCode({required String email});

  Future<Either<Failure, void>> confirmEmail({required String code});
}
