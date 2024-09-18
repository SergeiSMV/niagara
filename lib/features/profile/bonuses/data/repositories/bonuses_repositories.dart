import 'package:niagara_app/core/common/data/mappers/pagination_mapper.dart';
import 'package:niagara_app/core/core.dart';
// import 'package:niagara_app/features/profile/bonuses/data/local/data_source/bonuses_local_data_source.dart';
import 'package:niagara_app/features/profile/bonuses/data/mappers/bonus_history_mapper.dart';
import 'package:niagara_app/features/profile/bonuses/data/mappers/bonuses_dto_mapper.dart';
// import 'package:niagara_app/features/profile/bonuses/data/mappers/bonuses_entity_mapper.dart';
import 'package:niagara_app/features/profile/bonuses/data/remote/data_source/bonuses_history_remote_data_source.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses.dart';
import 'package:niagara_app/features/profile/bonuses/domain/repositories/bonuses_repository.dart';
import 'package:niagara_app/features/profile/user/data/remote/data_source/profile_remote_data_source.dart';

@LazySingleton(as: IBonusesRepository)
class BonusesRepository extends BaseRepository implements IBonusesRepository {
  BonusesRepository(
    // this._bonusesLDS,
    this._bonusesHistoryRDS,
    this._profileRDS,
    super._logger,
    super._networkInfo,
  );

  // TODO(kvbykov): Сейчас кеширование бонусов де-факто перестало использоваться
  // из-за багов с сохранением их в БД, в будущем нужно починить это и вернуть
  // кеширование.
  // final IBonusesLocalDataSource _bonusesLDS;
  final IBonusesHistoryRemoteDataSource _bonusesHistoryRDS;
  final IProfileRemoteDataSource _profileRDS;

  @override
  Failure get failure => const BonusesRepositoryFailure();

  @override
  Future<Either<Failure, Bonuses>> getBonuses() => execute(
        () => _profileRDS.getProfile().fold(
              (failure) => throw failure,
              (profile) => profile.toBonusesModel(),
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
