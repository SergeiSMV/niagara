import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/status_level_type.dart';
import 'package:niagara_app/features/profile/bonuses/data/mappers/bonuses_program_mapper.dart';
import 'package:niagara_app/features/profile/bonuses/data/remote/data_source/bonus_program_remote_data_source.dart';
import 'package:niagara_app/features/profile/bonuses/data/remote/dto/about_bonus_program_dto.dart';
import 'package:niagara_app/features/profile/bonuses/data/remote/dto/faq_bonuses_dto.dart';
import 'package:niagara_app/features/profile/bonuses/data/remote/dto/status_description_dto.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses_program.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/status_description.dart';
import 'package:niagara_app/features/profile/bonuses/domain/repositories/bonuses_program_repository.dart';

@LazySingleton(as: IBonusesProgramRepository)
class BonusesProgramRepository extends BaseRepository
    implements IBonusesProgramRepository {
  BonusesProgramRepository(
    super._logger,
    this._bonusProgramRDS,
  );

  final IBonusProgramRemoteDataSource _bonusProgramRDS;

  @override
  Failure get failure => const BonusesRepositoryFailure();

  @override
  Future<Either<Failure, BonusesProgram>> getBonusesProgram() =>
      execute(() async {
        final results = await Future.wait([
          _bonusProgramRDS.getAboutBonusProgram(),
          _bonusProgramRDS.getStatusesDescription(),
          _bonusProgramRDS.getFaqBonusProgram(),
        ]);

        final about = results[0].fold(
          (failure) => throw failure,
          (dto) => (dto as AboutBonusProgramDto).toModel(),
        );

        final statuses = results[1].fold(
          (failure) => throw failure,
          (dtos) => (dtos as List<StatusDescriptionDto>)
              .map((dto) => dto.toModel())
              .toList(),
        );

        final faqs = results[2].fold(
          (failure) => throw failure,
          (dtos) => (dtos as List<FaqBonusesDto>)
              .map((dto) => dto.toModel())
              .toList(),
        );

        return BonusesProgram(
          aboutBonusProgram: about,
          statusesDescriptions: statuses,
          faqBonuses: faqs,
        );
      });

  @override
  Future<Either<Failure, StatusDescription>> getStatus(StatusLevel status) =>
      execute(() async {
        final dto = await _bonusProgramRDS.getStatusDescription(
          status: status.convertStatusLevelToString,
        );
        return dto.fold(
          (failure) => throw failure,
          (dto) => dto.toModel(),
        );
      });
}
