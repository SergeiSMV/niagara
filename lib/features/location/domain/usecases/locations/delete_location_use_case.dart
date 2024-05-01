import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/domain/models/location.dart';
import 'package:niagara_app/features/location/domain/repositories/locations_repository.dart';

@injectable
class DeleteLocationUseCase extends BaseUseCase<void, Location> {
  DeleteLocationUseCase({
    required ILocationsRepository repository,
  }) : _repository = repository;

  final ILocationsRepository _repository;

  @override
  Future<Either<Failure, void>> call(Location params) =>
      _repository.deleteLocation(params);
}
