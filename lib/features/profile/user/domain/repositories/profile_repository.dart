import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/user/domain/models/user.dart';

abstract interface class IProfileRepository {
  Future<Either<Failure, User>> getUser();
  Future<Either<Failure, void>> updateUser(User user);
  Future<Either<Failure, void>> deleteUser(User user);
  Future<Either<Failure, void>> sendEmailCode({required String email});
  Future<Either<Failure, void>> confirmEmail({required String code});
}
