import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/user/domain/models/user.dart';

abstract interface class IProfileRepository {
  Future<Either<Failure, User>> getUser();

  Future<Either<Failure, void>> updateUser(User user);
}
