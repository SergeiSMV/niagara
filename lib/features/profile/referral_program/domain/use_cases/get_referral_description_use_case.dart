import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/referral_program/domain/model/referral_description.dart';
import 'package:niagara_app/features/profile/referral_program/domain/repositories/referral_repository.dart';

@injectable
class GetReferralDescriptionUseCase
    extends BaseUseCase<ReferralDescription, NoParams> {
  const GetReferralDescriptionUseCase(this._referralRepo);

  final IReferralRepository _referralRepo;

  @override
  Future<Either<Failure, ReferralDescription>> call(NoParams params) =>
      _referralRepo.getDescription();
}
