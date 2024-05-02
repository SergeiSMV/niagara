import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/domain/repositories/locations_repository.dart';

@injectable
class HasLocationsUseCase extends BaseUseCase<bool, NoParams> {
  HasLocationsUseCase({
    required ILocationsRepository repository,
  }) : _repository = repository;

  final ILocationsRepository _repository;

  @override
  Future<Either<Failure, bool>> call([NoParams? params]) =>
      _repository.getLocations().fold(
            (failure) => throw failure,
            (locations) => Right(locations.isNotEmpty),
          );
}
