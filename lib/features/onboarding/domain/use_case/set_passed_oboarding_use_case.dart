import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/onboarding/domain/repository/onboarding_repository.dart';

@injectable
class SetPassedOnboardingUseCase extends BaseUseCase<void, NoParams> {
  SetPassedOnboardingUseCase(this._onboardingRepository);

  final IOnboardingRepository _onboardingRepository;

  @override
  Future<Either<Failure, void>> call([NoParams? params]) async {
    return _onboardingRepository.setPassed();
  }
}
