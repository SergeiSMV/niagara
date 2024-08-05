import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/policy_type.dart';
import 'package:niagara_app/features/profile/about/domain/model/policy.dart';

abstract interface class IPoliciesRepository {
  Future<Either<Failure, Policy>> getPolicy({required PolicyType type});
}
