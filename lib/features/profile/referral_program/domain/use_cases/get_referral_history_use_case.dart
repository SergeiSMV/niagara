import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/referral_program/domain/model/referral_history.dart';
import 'package:niagara_app/features/profile/referral_program/domain/repositories/referral_repository.dart';

@injectable
class GetReferralHistoryUseCase extends BaseUseCase<ReferralHistory, int> {
  const GetReferralHistoryUseCase(this._referralRepo);

  final IReferralRepository _referralRepo;

  @override
  Future<Either<Failure, ReferralHistory>> call(int page) =>
      _referralRepo.getHistory(page: page);
}
