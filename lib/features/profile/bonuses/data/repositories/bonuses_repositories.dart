import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/bonuses/data/local/data_source/bonuses_local_data_source.dart';
import 'package:niagara_app/features/profile/bonuses/data/mappers/bonuses_entity_mapper.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses.dart';
import 'package:niagara_app/features/profile/bonuses/domain/repositories/bonuses_repository.dart';

@LazySingleton(as: IBonusesRepository)
class BonusesRepository extends BaseRepository implements IBonusesRepository {
  BonusesRepository(
    this._bonusesLDS,
    super.logger,
  );

  final IBonusesLocalDataSource _bonusesLDS;

  @override
  Failure get failure => const BonusesRepositoryFailure();

  @override
  Future<Either<Failure, Bonuses>> getBonuses() => execute(
        () => _bonusesLDS.getBonuses().fold(
              (failure) => throw failure,
              (bonusesEntity) => bonusesEntity.toModel(),
            ),
      );
}
