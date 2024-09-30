import 'package:niagara_app/core/common/data/mappers/pagination_mapper.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/referral_program/data/mappers/description_mapper.dart';
import 'package:niagara_app/features/profile/referral_program/data/remote/data_source/referral_remote_data_source.dart';
import 'package:niagara_app/features/profile/referral_program/domain/model/referral_code_data.dart';
import 'package:niagara_app/features/profile/referral_program/domain/model/referral_description.dart';
import 'package:niagara_app/features/profile/referral_program/domain/model/referral_history.dart';
import 'package:niagara_app/features/profile/referral_program/domain/repositories/referral_repository.dart';

@LazySingleton(as: IReferralRepository)
class ReferralRepository extends BaseRepository implements IReferralRepository {
  ReferralRepository(
    super.logger,
    super.networkInfo,
    this._referralRDS,
  );

  final IReferralRemoteDataSource _referralRDS;

  @override
  Failure get failure => const ReferralRepositoryFailure();

  @override
  Future<Either<Failure, ReferralDescription>> getDescription() => execute(
        () => _referralRDS.getDescription().fold(
              (failure) => throw failure,
              (dto) => dto.toModel(),
            ),
      );

  @override
  Future<Either<Failure, ReferralHistory>> getHistory({required int page}) =>
      execute(
        () => _referralRDS.getHistory(page: page).fold(
              (failure) => throw failure,
              (dto) => (
                history: dto.history.map((e) => e.toModel()).toList(),
                pagination: dto.pagination.toModel(),
              ),
            ),
      );

  @override
  Future<Either<Failure, ReferralCodeData>> createCode() => execute(
        () => _referralRDS.createCode().fold(
              (failure) => throw failure,
              (dto) => dto.toModel(),
            ),
      );
}
