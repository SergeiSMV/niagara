import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/domain/models/location.dart';
import 'package:niagara_app/features/location/domain/repositories/locations_repository.dart';

@injectable
class AddLocationUseCase extends BaseUseCase<void, Location> {
  AddLocationUseCase({
    required ILocationsRepository repository,
  }) : _repository = repository;

  final ILocationsRepository _repository;

  @override
  Future<Either<Failure, void>> call(Location params) =>
      _repository.addLocation(params);
}
