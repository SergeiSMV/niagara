import 'package:niagara_app/core/common/data/mappers/pagination_mapper.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/bonuses/data/local/data_source/bonuses_local_data_source.dart';
import 'package:niagara_app/features/profile/bonuses/data/mappers/bonus_history_mapper.dart';
import 'package:niagara_app/features/profile/bonuses/data/mappers/bonuses_entity_mapper.dart';
import 'package:niagara_app/features/profile/bonuses/data/remote/data_source/bonuses_history_remote_data_source.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses.dart';
import 'package:niagara_app/features/profile/bonuses/domain/repositories/bonuses_repository.dart';

@LazySingleton(as: IBonusesRepository)
class BonusesRepository extends BaseRepository implements IBonusesRepository {
  BonusesRepository(
    this._bonusesLDS,
    this._bonusesHistoryRDS,
    super._logger,
  );

  final IBonusesLocalDataSource _bonusesLDS;
  final IBonusesHistoryRemoteDataSource _bonusesHistoryRDS;

  @override
  Failure get failure => const BonusesRepositoryFailure();

  @override
  Future<Either<Failure, Bonuses>> getBonuses() => execute(
        () => _bonusesLDS.getBonuses().fold(
              (failure) => throw failure,
              (bonusesEntity) => bonusesEntity.toModel(),
            ),
      );

  @override
  Future<Either<Failure, BonusesHistory>> getHistory({
    required int page,
  }) =>
      execute(
        () => _bonusesHistoryRDS.geBonusesHistory(page: page).fold(
              (failure) => throw failure,
              (dto) => (
                history: dto.history.map((e) => e.toModel()).toList(),
                pagination: dto.pagination.toModel(),
              ),
            ),
      );
}
