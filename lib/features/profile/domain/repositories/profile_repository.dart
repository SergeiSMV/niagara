import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/domain/models/user.dart';

abstract interface class IProfileRepository {
  /// Получает данные пользователя.
  Future<Either<Failure, User>> getUser();
  
  /// Обновляет данные пользователя.
  Future<Either<Failure, void>> updateUser(User user);
}
