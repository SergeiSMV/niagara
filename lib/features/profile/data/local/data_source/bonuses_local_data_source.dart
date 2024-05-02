import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/data/local/entities/bonuses_entity.dart';
import 'package:niagara_app/features/profile/data/mappers/bonuses_entity_mapper.dart';

abstract interface class IBonusesLocalDataSource {
  Future<Either<Failure, BonusesEntity>> getBonuses();

  Future<Either<Failure, void>> saveBonuses(BonusesEntity bonuses);

  Future<Either<Failure, void>> updateBonuses(BonusesEntity bonuses);
}

@LazySingleton(as: IBonusesLocalDataSource)
class BonusesLocalDataSource implements IBonusesLocalDataSource {
  BonusesLocalDataSource({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  @override
  Future<Either<Failure, BonusesEntity>> getBonuses() => _execute(
        () async => (await _database.allBonuses.getBonuses()).toEntity(),
      );

  @override
  Future<Either<Failure, void>> saveBonuses(BonusesEntity bonuses) => _execute(
        () => _database.allBonuses.insertBonuses(bonuses.toCompanion()),
      );

  @override
  Future<Either<Failure, void>> updateBonuses(BonusesEntity bonuses) =>
      _execute(
        () => _database.allBonuses.updateBonuses(bonuses.toCompanion()),
      );

  Future<Either<Failure, T>> _execute<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return Right(result);
    } on Exception catch (e) {
      return Left(BonusesLocalDataFailure(e.toString()));
    }
  }
}
