import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/about/domain/model/policy.dart';
import 'package:niagara_app/features/profile/about/domain/repositories/policies_repository.dart';

@injectable
class GetPoliciesUseCase extends BaseUseCase<Policy, PolicyType> {
  const GetPoliciesUseCase(this._repo);

  final IPoliciesRepository _repo;

  @override
  Future<Either<Failure, Policy>> call(PolicyType type) async =>
      _repo.getPolicy(type: type.name);
}

enum PolicyType {
  agreement,
  offer,
  privacy,
}
