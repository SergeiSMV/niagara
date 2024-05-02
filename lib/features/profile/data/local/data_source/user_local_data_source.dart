import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/data/local/entities/user_entity.dart';
import 'package:niagara_app/features/profile/data/mappers/user_entity_mapper.dart';

abstract interface class IUserLocalDataSource {
  Future<Either<Failure, UserEntity?>> getUser();

  Future<Either<Failure, void>> saveUser(UserEntity userEntity);

  Future<Either<Failure, void>> updateUser(UserEntity userEntity);
}

@LazySingleton(as: IUserLocalDataSource)
class UserLocalDataSource implements IUserLocalDataSource {
  UserLocalDataSource({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  @override
  Future<Either<Failure, UserEntity?>> getUser() => _execute(
        () async => (await _database.allUsers.getUser())?.toEntity(),
      );

  @override
  Future<Either<Failure, void>> saveUser(UserEntity userEntity) => _execute(
        () => _database.allUsers.insertUser(userEntity.toCompanion()),
      );

  @override
  Future<Either<Failure, void>> updateUser(UserEntity userEntity) => _execute(
        () => _database.allUsers.updateUser(userEntity.toCompanion()),
      );

  Future<Either<Failure, T>> _execute<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return Right(result);
    } on Exception catch (e) {
      return Left(UserLocalDataFailure(e.toString()));
    }
  }
}
