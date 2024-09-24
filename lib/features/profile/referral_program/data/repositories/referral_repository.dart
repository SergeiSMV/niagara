import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/referral_program/data/mappers/description_mapper.dart';
import 'package:niagara_app/features/profile/referral_program/data/remote/data_source/referral_remote_data_source.dart';
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
  Future<Either<Failure, ReferralDescription>> getDescription() {
    return execute(() async {
      return await _referralRDS.getDescription().fold(
            (failure) => throw failure,
            (dto) => dto.toModel(),
          );
    });
  }

  @override
  Future<Either<Failure, ReferralHistory>> getHistory() {
    return execute(() async {
      return await _referralRDS.getHistory().fold(
            (failure) => throw failure,
            (dto) => dto.map((e) => e.toModel()).toList(),
          );
    });
  }
}
