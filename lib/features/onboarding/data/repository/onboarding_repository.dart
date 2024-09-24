import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/onboarding/data/data_source/onboarding_local_data_source.dart';
import 'package:niagara_app/features/onboarding/domain/repository/onboarding_repository.dart';

@LazySingleton(as: IOnboardingRepository)
class OnboardingRepository extends BaseRepository
    implements IOnboardingRepository {
  OnboardingRepository(
    this._localDataSource,
    super._logger,
    super._networkInfo,
  );

  final IOnboardingLocalDataSource _localDataSource;

  @override
  Failure get failure => throw UnimplementedError();

  @override
  Future<Either<Failure, bool>> isPassed() => execute(
        () async => _localDataSource.isPassed(),
      );

  @override
  Future<Either<Failure, void>> setPassed() => execute(
        () => _localDataSource.setPassed(),
      );
}
