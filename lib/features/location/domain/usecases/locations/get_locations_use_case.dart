import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/domain/models/location.dart';
import 'package:niagara_app/features/location/domain/repositories/locations_repository.dart';

@injectable
class GetLocationsUseCase extends BaseUseCase<List<Location>, NoParams> {
  GetLocationsUseCase({
    required ILocationsRepository repository,
  }) : _repository = repository;

  final ILocationsRepository _repository;

  @override
  Future<Either<Failure, List<Location>>> call([NoParams? params]) =>
      _repository.getLocations();
}
