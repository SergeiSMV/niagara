import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/policy_type.dart';
import 'package:niagara_app/features/profile/about/domain/model/policy.dart';
import 'package:niagara_app/features/profile/about/domain/repositories/policies_repository.dart';

@injectable
class GetPoliciesUseCase extends BaseUseCase<Policy, PolicyType> {
  const GetPoliciesUseCase(this._repo);

  final IPoliciesRepository _repo;

  @override
  Future<Either<Failure, Policy>> call(PolicyType type) =>
      _repo.getPolicy(type: type);
}
