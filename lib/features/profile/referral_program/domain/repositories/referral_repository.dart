import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/referral_program/domain/model/referral_code_data.dart';
import 'package:niagara_app/features/profile/referral_program/domain/model/referral_description.dart';
import 'package:niagara_app/features/profile/referral_program/domain/model/referral_history.dart';

abstract interface class IReferralRepository {
  Future<Either<Failure, ReferralDescription>> getDescription();
  Future<Either<Failure, ReferralHistory>> getHistory({required int page});
  Future<Either<Failure, ReferralCodeData>> createCode();
}
