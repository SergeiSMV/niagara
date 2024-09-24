import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/onboarding/domain/repository/onboarding_repository.dart';

@injectable
class CheckOnboardingPassedUseCase extends BaseUseCase<bool, NoParams> {
  CheckOnboardingPassedUseCase(this._onboardingRepository);

  final IOnboardingRepository _onboardingRepository;

  @override
  Future<Either<Failure, bool>> call([NoParams? params]) =>
      _onboardingRepository.isPassed();
}
