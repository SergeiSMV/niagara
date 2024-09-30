import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/referral_program/domain/model/referral_code_data.dart';
import 'package:niagara_app/features/profile/referral_program/domain/repositories/referral_repository.dart';

@injectable
class CreateReferralCodeUseCase
    extends BaseUseCase<ReferralCodeData, NoParams> {
  const CreateReferralCodeUseCase(this._referralRepo);

  final IReferralRepository _referralRepo;

  @override
  Future<Either<Failure, ReferralCodeData>> call(NoParams params) =>
      _referralRepo.createCode();
}
