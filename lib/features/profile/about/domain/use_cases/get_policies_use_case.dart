import '../../../../../core/core.dart';
import '../../../../../core/utils/enums/policy_type.dart';
import '../model/policy.dart';
import '../repositories/policies_repository.dart';

/// Usecase для получения политики конфиденциальности или маркетингового
/// соглашения
@injectable
class GetPoliciesUseCase extends BaseUseCase<Policy, PolicyType> {
  const GetPoliciesUseCase(this._repo);

  /// Репозиторий для работы с политикой конфиденциальности и маркетинговым
  /// соглашением
  final IPoliciesRepository _repo;

  /// Выполнение usecase
  @override
  Future<Either<Failure, Policy>> call(PolicyType type) =>
      _repo.getPolicy(type: type);
}
